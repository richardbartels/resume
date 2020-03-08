# CV 

## CV on website
The code was adapted from [this repository](https://github.com/thomastweets/cv-on-ghpages).

### TravisCI
When you clone or fork this repository make sure that you enable it on [TravisCI](https://travis-ci.org).

#### TravisCI API key
As Travis CI needs to be able to push to your GitHub repository (specifically the `gh-pages` branch) you need to authenticate it.
As you do not want to store any passwords, ssh, or API keys in your repo or the TravisCI configuration the easiest way is to use the
`travis` command line tool that is available as a gem to encrypt an Authentication Token for GitHub so that Travis CI 
can decrypt it when needed. First we need to install it:
```bash
# on OSX using the default Ruby installation
sudo gem install travis
```
Now we create a personal access token on GitHub to use with Travis CI. Follow
[these instructions](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) 
to do so. Copy the token when you created 
it as you will not be able to see it again after you close the page.
Encrypt the token with the `travis` command line tool:
```bash
# where 'your_token' is the token from the last step
travis encrypt GH_TOKEN=your_token
```
Copy the resulting key to line 18 of the `.travis.yml` file (replace `yoursecret` but keep the quotes):
```yml
env:
  global:
    - secure: "yoursecret"
```

### CNAME file (custom domain)
Change the `CNAME` file to your needs if you want to be able to redirect a custom domain name to your CV. Refer to [GitHub](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/) for help in setting up a corresponding DNS entry at your DNS provider.

## Licence
The CV template is adapted from
Trey Hunter's [Medium Length Professional CV](https://www.latextemplates.com/template/medium-length-professional-cv) and downloaded from
`http://www.LaTeXTemplates.com`.
The code for GitHub pages is adapted from [here](https://github.com/thomastweets/cv-on-ghpages).
