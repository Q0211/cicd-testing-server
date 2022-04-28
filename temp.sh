str=$(find ./ -name .git)
cd $str
echo abs

str=${str:2}
str=${str:0:-9}
repository_organization_name=$(echo $str | cut -d '-' -f1)
repository_name=$(echo $str | cut -d '-' -f2)

echo ===================
echo $repository_organization_name
echo $repository_name
echo ===================


