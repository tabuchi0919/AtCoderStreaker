require './atcoder_streaker'

file = File.open('dump', 'r')
atcoder_streaker = Marshal.load(file)
atcoder_streaker.remind_users
file.close
