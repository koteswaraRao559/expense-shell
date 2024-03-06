log_file=/tmp/expense.log
color="\e[31m"

status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
  else
    echo -e "\e[33m Failure \e[0m"
  fi
}