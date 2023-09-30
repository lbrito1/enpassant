# Add to crontab
echo -e $(date -u) "\t[Updating crontab]"
crontab -l > crontab_tmp
echo -e "\n# Added by enpassant bin/setup.sh script\n0 12 * * 6 /bin/bash -l -c 'cd /home/leo/work/enpassant && bundle exec bin/deploy.sh' > /home/leo/work/enpassant/log/cron.log 2>&1" >> crontab_tmp
crontab crontab_tmp
rm crontab_tmp
