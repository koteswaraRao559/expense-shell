echo -e "\e[31m installing nginx \e[0m"
dnf install nginx -y &>> /tmp/expense.log

echo -e "\e[32m copying file  \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> /tmp/expense.log

echo -e "\e[33m removing file  \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[35m Downloading Zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> /tmp/expense.log


cd /usr/share/nginx/html
echo -e "\e[34m unziping  \e[0m"
unzip /tmp/frontend.zip &>> /tmp/expense.log

echo -e "\e[31m starting nginx services \e[0m"
systemctl enable nginx&>> /tmp/expense.log
systemctl restart nginx&>> /tmp/expense.log


