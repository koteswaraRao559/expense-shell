log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} Disabling Default mysql \e[0m"
dnf module disable mysql -y &>>log_file
echo $?

echo -e "${color} copying MySql repofile \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
echo $?

echo -e "${color} Installing MySql Server \e[0m"
dnf install mysql-community-server -y &>>log_file
echo $?

echo -e "${color} enabling MySql Server\e[0m"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
echo $?

echo -e "${color} setting MySql password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
echo $?
