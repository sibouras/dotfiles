# Git setup

[configure-git.md](https://gist.github.com/qin-yu/bc26a2d280ee2e93b2d7860a1bfbd0c5)

1. Check keys to reuse
   `ls -alhF ~/.ssh/`

2. Generate key pair
   `ssh-keygen -t ed25519 -C "your_email@gmail.com"`

3. Add key to ssh-agent
   `eval (ssh-agent -c)`

   kill ssh agent processs `killall ssh-agent` after spamming `eval (ssh-agent -c)`
   `pgrep ssh-agent` might return multiple processes.

   `ssh-add ~/.ssh/id_rsa`

4. Paste public key to GitHub i.e. copy the content of ~/.ssh/id_rsa.pub into
   GitHub -> Personal Settings -> SSH and GPG keys -> New SSH Key

5. Test
   do `ssh -T git@github.com` but don't just type "yes"

   Check if the hash that is shown matches one of the hashed shown in
   https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints

   If the hash matches, then connection is indeed safe you can answer "yes" to ssh's question.

## wsl and gitui

how to fix gitui error `fetch failed: git error: Bad credentials.`

after `wsl --shutdown` the ssh agent is killed

```bash
# list running ssh-agent process
pgrep ssh-agent
# add key to ssh-agent
eval (ssh-agent -c)
.
# list fingerprints of all identities
ssh-add -l
ssh-add ~/.ssh/id_ed25519
```
