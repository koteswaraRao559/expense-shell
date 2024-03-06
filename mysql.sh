source common.sh

if [ -z "$1" ]; then
  echo password input missing
  exit
fi
MY_SQL_ROOT_PASSWORD=$1

echo -e "${color} Disabling Default mysql \e[0m"
dnf module disable mysql -y &>>log_file
status_check

echo -e "${color} copying MySql repofile \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
status_check


echo -e "${color} Installing MySql Server \e[0m"
dnf install mysql-community-server -y &>>log_file
status_check

echo -e "${color} enabling MySql Server\e[0m"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
status_check

echo -e "${color} setting MySql password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
status_check
