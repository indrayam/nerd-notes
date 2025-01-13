# jq

[Source: An Introduction to JQ](https://earthly.dev/blog/jq-select/)

## Note
- Keys of an object cannot have "-" in their value

## Pretty Print

```bash
echo '{"key1":{"key2":"value1"}}' | jq '.'

# Actually, you do not the '.'
echo '{"key1":{"key2":"value1"}}' | jq
```

## Select Elements

```bash
# We will play with this API endpoint
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq '.'

# The last two lines being '}' followed by ']' tells me it is an array of objects

# Let's very quickly find out how many entries the array has
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq 'length'

# Let's find out what the keys in each object
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq '.[0] | keys'

# Let's say I just want a simpler output with the id and title of the issue
# Notice that the previous output of the keys really helped here
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq '.[] | { id: .id, title: .title}'

# One more hack. Most single outputs of type string are output with double-quotes. If you want the raw output, just put a -r
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq -r '.[0].title'
```

### Map/Select

```bash
# map is a function that takes an array and applies a function to each element of the array
# Let's say I want to find out the number of issues each user has created
# I will group by the user.login, count the number of issues and sort by the count
curl -L -s https://api.github.com/repos/stedolan/jq/issues | jq 'group_by(.user.login) | map({login: .[0].user.login, count: length}) | sort_by(-.count)'

# In the example below, I have selected the top 3 submitters of issues
curl -s https://api.github.com/repos/simonw/datasette/issues | jq 'group_by(.user.login) | map({login: .[0].user.login, count: length}) | sort_by(-.count) | .[:3]'
```
