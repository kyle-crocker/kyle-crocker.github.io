hugo                               
cd public
git pull https://github.com/karnagowda/karnagowda.github.io master:dev
git add --all
git commit -m "Build website"
git pull https://github.com/karnagowda/karnagowda.github.io master:dev
git push https://github.com/karnagowda/karnagowda.github.io master:dev
cd ..