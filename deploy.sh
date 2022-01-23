hugo                               
git add .
git commit -m "Build website"
git push origin master
cd public
git init
git add .
git commit -m "Build website"
git push -f https://github.com/karnagowda/karnagowda.github.io master
cd ..