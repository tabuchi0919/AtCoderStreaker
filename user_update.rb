require './atcoder_streaker'

file = File.open('dump', 'r')
atcoder_streaker = Marshal.load(file)
atcoder_streaker.update_users
file.close

file = File.open('dump', 'w')
Marshal.dump(atcoder_streaker, file)
file.close