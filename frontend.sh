log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} installing nginx \e[0m"
dnf install nginx -y &>> log_file
echo $?

echo -e "${color} copying file  \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> log_file
echo $?

echo -e "${color} removing file  \e[0m"
rm -rf /usr/share/nginx/html/*
echo $?

echo -e "${color} Downloading Zip file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>> log_file
echo $?

cd /usr/share/nginx/html
echo -e "${color} unziping  \e[0m"
unzip /tmp/frontend.zip &>> log_file
echo $?

echo -e "${color} starting nginx services \e[0m"
systemctl enable nginx&>> log_file
echo $?
systemctl restart nginx&>> log_file
echo $?


