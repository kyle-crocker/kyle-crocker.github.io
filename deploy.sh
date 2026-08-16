hugo                               
# git add .
# git commit -m "Build website"
# git push origin master
cd public
#git remote set-url origin git@github.com:kyle-crocker/kyle-crocker.github.io
git init
#git remote add origin git@github.com:kyle-crocker/kyle-crocker.github.io
#git remote set-url origin git@github.com:kyle-crocker/kyle-crocker.github.io
#git push --set-upstream origin master
git add .
#git add -A
git commit -m "Build website"
#git push --set-upstream origin master
git push -f git@github.com:kyle-crocker/kyle-crocker.github.io master
cd ..