#!/bin/bash

echo "================================================================="

python3 -c "import TreeHue.treehue_colored as tree; tree.tree('./')"

#TOKEN=$1
#FILE_PATH=$2
#BRANCH=$3
#COMMIT_MESSAGE=$4

# Access input parameters using environment variables
TOKEN=$INPUT_TOKEN
BRANCH=$INPUT_BRANCH
REPOSITORY=$INPUT_REPOSITORY
FILE_PATH=$INPUT_FILE
COMMIT_MESSAGE=$INPUT_COMMIT_MESSAGE

echo "FILE_PATH=$FILE_PATH"
echo "BRANCH = $BRANCH"
echo "REPOSITORY = $REPOSITORY"
echo "COMMIT_MESSAGE=$COMMIT_MESSAGE"

# Get the commit SHA of the latest commit for the README.md file
COMMIT_SHA=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$REPOSITORY/commits?path=$FILE_PATH&sha=$BRANCH" | jq -r '.[0].sha')

if [[ -z "$COMMIT_SHA" ]]; then
  echo "Failed to retrieve the latest commit SHA for the file: $FILE_PATH"
  exit 1
else
  echo "Commit SHA: $COMMIT_SHA"
fi

# Get the file SHA from the /contents endpoint
FILE_SHA=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$REPOSITORY/contents/$FILE_PATH?ref=$BRANCH" | jq -r '.sha')

if [[ -z "$FILE_SHA" ]]; then
  echo "Failed to retrieve the current FILE SHA for the file: $FILE_PATH"
  exit 1
fi

# Get the current file contents
FILE_CONTENT=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/$REPOSITORY/contents/$FILE_PATH?ref=$BRANCH" | jq -r '.content')

if [[ -z "$FILE_CONTENT" ]]; then
  echo "Failed to retrieve the current content of the file: $FILE_PATH"
  exit 1
fi

# Decode the file contents
FILE_CONTENT=$(echo "$FILE_CONTENT" | base64 -d)

# Update the file content with the new version
NEW_VERSION=$(cat version.txt)
UPDATED_CONTENT=$(echo "$FILE_CONTENT" | sed "s/last stable version: .*/last stable version: $NEW_VERSION/")

# Encode the updated content
UPDATED_CONTENT=$(echo -n "$UPDATED_CONTENT" | base64)

# Print debug information
echo "TOKEN: $TOKEN"
echo "NEW_VERSION: $NEW_VERSION"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "FILE_SHA: $FILE_SHA"

# Prepare the JSON data
JSON_DATA=$(jq -n --arg message "$COMMIT_MESSAGE" --arg content "$UPDATED_CONTENT" --arg branch "$BRANCH" --arg sha "$FILE_SHA" \
  '{message: $message, content: $content, branch: $branch, sha: $sha}')

# Update the file on GitHub
RESPONSE=$(curl -s -X PUT \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "$JSON_DATA" \
  "https://api.github.com/repos/$REPOSITORY/contents/$FILE_PATH")

echo "$RESPONSE"
echo "================================================================="

