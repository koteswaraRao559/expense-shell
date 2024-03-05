log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} Disabling Default node.js \e[0m"
dnf module disable nodejs -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi

echo -e "${color} Enabling & installing Node.js of version 18 \e[0m"
dnf module enable nodejs:18 -y &>>log_file
dnf install nodejs -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi

echo -e "${color} Coping backend.service file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi


id expense &>>log_file
if [ $? -ne 0 ]; then
  echo -e "${color} Adding User \e[0m"
  useradd expense &>>log_file
  if [ $? -eq 0 ]; then
    echo -e "\e[32m sucess \e[0m"
  else
    echo -e "\e[33m Failure \e[0m"
  fi
fi

echo -e "${color} creating a directory \e[0m"
mkdir /app &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi

echo -e "${color} Download Application content  \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app
echo -e "${color} Extracting Application content\e[0m"
unzip /tmp/backend.zip
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi

cd /app
echo -e "${color} Download nodejs Dependencies \e[0m"
npm install &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi

echo -e "${color} Installing mysql to load Schema \e[0m"
dnf install mysql -y &>>log_file
echo -e "${color} Load Schema \e[0m"
mysql -h mysql-dev.kdevops59.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi
echo -e "${color} Stating Backend services \e[0m"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m sucess \e[0m"
else
  echo -e "\e[33m Failure \e[0m"
fi


