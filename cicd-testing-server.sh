

#################################################################################
function clone_repository()
{

repository_url=$(<repository-list.txt)

echo ===================
echo $repository_url
echo ===================

git clone $repository_url remote_repositories/Q0211-kyu_test.git

cd remote_repositories
}
#################################################################################
function check_latest_commit()
{
    str=$(find ./ -name .git -type d)
    str=${str:0:-4}
    cd $str 

    str=${str:2}
    str=${str:0:-5}
    repository_organization_name=$(echo $str | cut -d '-' -f1)
    repository_name=$(echo $str | cut -d '-' -f2)

    echo $repository_organization_name
    echo $repository_name

    fetch_result=$(git fetch origin HEAD:HEAD 2>&1)


    if [ 0 != ${#fetch_result} ]
    then
        git merge origin
    fi
    
}
#################################################################################
function auto_testing()
{
    str=$(find ./ -name .git)
    str=${str:0:-4}
    cd $str

    str=${str:2}
    str=${str:0:-9}
    repository_organization_name=$(echo $str | cut -d '-' -f1)
    repository_name=$(echo $str | cut -d '-' -f2)

    settings=$(<cicd-setting.txt)
    build=$(echo $settings | cut -d ',' -f1)
    run=$(echo $settings | cut -d ',' -f2)
    input=$(echo $settings | cut -d ',' -f3)
    output=$(echo $settings | cut -d ',' -f4)
    error=$(echo $settings | cut -d ',' -f5)
    time_out=$(echo $settings | cut -d ',' -f6)

    $build
    $run > /"error_log.txt" 2>&1


    find . -name cicd-stting.txt

}
#################################################################################
function merge_branch()
{
    str=$(find ./ -name .git)
    cd $str

    str=${str:2}
    str=${str:0:-9}
    repository_organization_name=$(echo $str | cut -d '-' -f1)
    repository_name=$(echo $str | cut -d '-' -f2)
    error_flag=0

    token=$(</tokens/Q0211-kyu_test.token)

    if [ $error_flag=0 ]
    then
        git merge origin
        git push origin
        expect -re "startree0211"
    fi
}