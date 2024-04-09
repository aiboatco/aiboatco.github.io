#!/bin/bash

# 指定输入的 CSV 文件路径
input_csv="202401.csv"

# 检查 CSV 文件是否存在
if [ ! -f $input_csv ]; then
    echo "CSV 文件不存在"
    exit 1
fi

# 将CSV文件内容从GBK转换为UTF-8编码
iconv -f gbk -t utf-8 "$input_csv" > "temp.csv"

# 逐行读取 CSV 文件并输出到单独的文件
while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13 col14 col15 col16 col17 col18 col19 col20
do

    # 如果 col1 等于 flex-shrink-0 href 则跳过循环
    if [ "$col1" == "flex-shrink-0 href" ]; then
        continue
    fi

    # 替换文件名中的特殊字符，以避免文件名错误
    file_name="${col1// /_}.html"
    
    # 输出行数据到文件中

echo "---" > "$file_name"
echo "permalink: /product/$col1" >> "$file_name"
echo "layout: product" >> "$file_name"
echo "" >> "$file_name"

echo "produrl: $col5" >> "$file_name"
echo "prodlogo: aaprodlogo" >> "$file_name"
echo "prodimage: /assets/images/202401/$col2" >> "$file_name"
echo "prodtitle: $col4" >> "$file_name"
echo "proddescription: $col10" >> "$file_name"

random_day=$(printf "%02d" $((1 + $RANDOM % 30)))

echo "prodindate: 2024-01-$random_day" >> "$file_name"
echo "prodauthor: admin" >> "$file_name"

echo "prodtags: $col12,$col14,$col16" >> "$file_name"

echo "---" >> "$file_name"

    echo "行数据已写入 $file_name"
done < "temp.csv"


# 删除临时文件
rm "temp.csv"

