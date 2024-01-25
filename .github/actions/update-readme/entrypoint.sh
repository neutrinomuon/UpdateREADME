#!/bin/bash

echo "================================================================="
echo
#echo "NAME = ${INPUT_NAME}"
#echo "EMAIL = ${INPUT_EMAIL}"

# Setup Git interface
# Track who is using this action to update the README.md file
git config user.name "Jean Gomes"
git config user.email "neutrinomuon@gmail.com"
# Make sure to add to the safe list of directories
git config --global --add safe.directory /github/workspace

#python3 -c "import TreeHue.treehue_colored as tree; tree.tree('./')"
python3 -c "import TreeHue.treehue_colored as tree; tree.tree('./',save_to_file='tree.out')"

# cat tree.out | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" > tree1.out
#     ^------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" tree.out > tree1.out

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
echo "BRANCH=$BRANCH"
echo "REPOSITORY=$REPOSITORY"
echo "COMMIT_MESSAGE=$COMMIT_MESSAGE"

# Get the commit SHA of the latest commit for the README.md file from API
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

# Get the file SHA from the /contents endpoint from API
FILE_SHA=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$REPOSITORY/contents/$FILE_PATH?ref=$BRANCH" | jq -r '.sha')

if [[ -z "$FILE_SHA" ]]; then
  echo "Failed to retrieve the current FILE SHA for the file: $FILE_PATH"
  exit 1
fi

# Get the current file contents from API
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
# Print to a file called $TEST_FILE
TEST_FILE='test_file'
echo "$FILE_CONTENT" > "$TEST_FILE"

# Sometimes there is no terminating newline in the file
# Check if the file ends with a newline
if [[ -n $(tail -c 1 "$FILE_PATH" | tr -d '\n') ]]; then
    # If not, add a newline
    echo >> "$FILE_PATH"
    echo "Added newline to $FILE_PATH"
else
    echo "File $file already ends with a newline"
fi

# Get the current file from local directory
FILE_CONTENT_LOCAL=$(cat "$FILE_PATH")

# Verify difference between both files
# Run diff and display the differences
diff_result=$(diff "$FILE_PATH" "$TEST_FILE")

# Check if there are differences
echo "Checking the $FILE_PATH!"
if [ $? -eq 0 ]; then
    echo "The files $FILE_PATH and $TEST_FILE are identical."
else
    echo "Differences found:"
    echo "$diff_result"
    echo "$FILE_CONTENT_LOCAL" > "$FILE_PATH"
fi

# Update the file content with the new version
VERSION_FILE="version.txt"
DEFAULT_VERSION="0.0.0" # In case $VERSION_FILE does not exist

# Check if the file exists
echo "Checking the version!"
if [ -e "$VERSION_FILE" ]; then
    # Read the content of the file into the variable
    NEW_VERSION=$(cat "$VERSION_FILE")
    echo "Updated the file content with the new version: $NEW_VERSION"
else
    # File doesn't exist, create it with the default version
    echo "$DEFAULT_VERSION" > "$VERSION_FILE"
    NEW_VERSION="$DEFAULT_VERSION"
    echo "Created $VERSION_FILE with the default version: $NEW_VERSION"
fi

# Now we are going to check the version published and the current from version.txt file
UPDATED_VERSION_CONTENT=$(echo "$FILE_CONTENT_LOCAL" | sed "/last stable version:/s/.*/last stable version: $NEW_VERSION/")
# Print to a file called $TEST_FILE
echo "$UPDATED_VERSION_CONTENT" > "$TEST_FILE"

# Verify difference between both files for the version
# Run diff and display the differences
diff_result=$(diff "$FILE_PATH" "$TEST_FILE")

# Check if there are differences
if [ $? -eq 0 ]; then
    echo "The files $FILE_PATH and $TEST_FILE are identical in what concerns the version control."
else
    echo "Differences found in version control:"
    echo "$diff_result"
    echo "$UPDATE_VERSION_CONTENT" > "$FILE_PATH"
    # Send changes back to the server
    git add -A
    git commit -m "Version control needed to be updated"
    # Push changes to the specified branch (using $BRANCH variable)
    git push --set-upstream origin "$BRANCH"
fi

# Read the content of tree.out file
TREE_CONTENT=$(cat tree1.out)
echo ""
echo "===== TREE_CONTENT DEBUG ====="
echo "$TREE_CONTENT"

# Check if README.md already contains a STRUCTURE section
echo ""
echo "Checking if README.md already contains a STRUCTURE section"

if [[ $UPDATED_VERSION_CONTENT =~ "#### <b>STRUCTURE" ]]; then
    UPDATED_FILE_CONTENT=$(awk '
/#### <b>STRUCTURE[^<]*<\/b>/,/\<\/pre>/ {
    if (/#### <b>STRUCTURE[^<]*<\/b>/) {
        print $0
        print "<pre>"
        while ((getline line < "tree1.out") > 0) {
            print line
        }
        in_block = 1
        next
    }
    if (/<\/pre>/) {
        in_block = 0
	print "</pre>"
        next
    }
    if (in_block) next
}
{ print }
' <<< "$UPDATED_VERSION_CONTENT")
else
    UPDATED_CONTENT="$UPDATED_CONTENT

<hr>

#### <b>STRUCTURE</b>
<pre>
$TREE_CONTENT
</pre>

<hr>"
fi

# Debugging output
echo ""
echo "=== UPDATED_CONTENT ==="
echo "$UPDATED_FILE_CONTENT"
echo ""

# Verify difference between both files for the content
# Print to a file called $TEST_FILE
echo "$UPDATED_FILE_CONTENT" > "$TEST_FILE"

# Run diff and display the differences                                                                                                                                                             
diff_result=$(diff "$FILE_PATH" "$TEST_FILE")

# Check if there are differences
if [ $? -eq 0 ]; then
    echo "The files $FILE_PATH and $TEST_FILE are identical in what concerns the content control."
else
    echo "Differences found in content control:"
    echo "$diff_result"
    echo "$UPDATE_FILE_CONTENT" > "$FILE_PATH"
    # Send changes back to the server
    git add .
    git commit -m "Content control needed to be updated"
    # Push changes to the specified branch (using $BRANCH variable)
    git push --set-upstream origin "$BRANCH"
fi

# ===> 
# ===>     # Check if UPDATED_CONTENT_NEW is different from UPDATED_CONTENT
# ===>     if [ "$UPDATED_CONTENT_NEW" != "$UPDATED_CONTENT" ]; then
# ===> 	# If different, update UPDATED_CONTENT
# ===> 	UPDATED_CONTENT="$UPDATED_CONTENT_NEW"
# ===> 	# Perform additional actions if needed
# ===> 	echo "Content updated"
# ===>     else
# ===> 	# If not different, do nothing
# ===> 	echo "Content unchanged"
# ===>     fi
# ===> 
# ===> else
# ===>     UPDATED_CONTENT="$UPDATED_CONTENT
# ===> 
# ===> <hr>
# ===> 
# ===> #### <b>STRUCTURE</b>
# ===> <pre>
# ===> $TREE_CONTENT
# ===> </pre>
# ===> 
# ===> <hr>"
# ===> fi

# Decode the file contents
# ===> FILE_CONTENT=$(echo "$FILE_CONTENT" | base64 -d)
# ===> 
# ===> # Update the file content with the new version
# ===> NEW_VERSION=$(cat version.txt)
# ===> 
# ===> # UPDATED_CONTENT=$(echo "$FILE_CONTENT" | sed "s/last stable version: .*/last stable version: $NEW_VERSION/")
# ===> #                   ^-- SC2001 (style): See if you can use ${variable//search/replace} instead.
# ===> 
# ===> # UPDATED_CONTENT=$(echo "$FILE_CONTENT" | sed "s/last stable version: .*/last stable version: $NEW_VERSION/")
# ===> UPDATED_CONTENT=$(echo "$FILE_CONTENT" | sed "/last stable version:/s/.*/last stable version: $NEW_VERSION/")
# ===> 
# ===> # Read the content of tree.out file
# ===> TREE_CONTENT=$(cat tree1.out)
# ===> echo ""
# ===> echo "TREE_CONTENT DEBUG"
# ===> echo "$TREE_CONTENT"
# ===> 
# ===> # Check if README.md already contains a STRUCTURE section                                                                                                                                     
# ===> if [[ $UPDATED_CONTENT =~ "#### <b>STRUCTURE" ]]; then
# ===>     UPDATED_CONTENT_NEW=$(awk '
# ===> /#### <b>STRUCTURE[^<]*<\/b>/,/\<\/pre>/ {
# ===>     if (/#### <b>STRUCTURE[^<]*<\/b>/) {
# ===>         print $0
# ===>         print "<pre>"
# ===>         while ((getline line < "tree1.out") > 0) {
# ===>             print line
# ===>         }
# ===>         in_block = 1
# ===>         next
# ===>     }
# ===>     if (/<\/pre>/) {
# ===>         in_block = 0
# ===> 	print "</pre>"
# ===>         next
# ===>     }
# ===>     if (in_block) next
# ===> }
# ===> { print }
# ===> ' <<< "$UPDATED_CONTENT")
# ===> 
# ===>     # Debugging output
# ===>     echo ""
# ===>     echo "=== UPDATED_CONTENT ==="
# ===>     echo "$UPDATED_CONTENT"
# ===>     echo ""
# ===>     echo "=== UPDATED_CONTENT_NEW ==="
# ===>     echo "$UPDATED_CONTENT_NEW"
# ===>     echo ""
# ===> 
# ===>     # Check if UPDATED_CONTENT_NEW is different from UPDATED_CONTENT
# ===>     if [ "$UPDATED_CONTENT_NEW" != "$UPDATED_CONTENT" ]; then
# ===> 	# If different, update UPDATED_CONTENT
# ===> 	UPDATED_CONTENT="$UPDATED_CONTENT_NEW"
# ===> 	# Perform additional actions if needed
# ===> 	echo "Content updated"
# ===>     else
# ===> 	# If not different, do nothing
# ===> 	echo "Content unchanged"
# ===>     fi
# ===> 
# ===> else
# ===>     UPDATED_CONTENT="$UPDATED_CONTENT
# ===> 
# ===> <hr>
# ===> 
# ===> #### <b>STRUCTURE</b>
# ===> <pre>
# ===> $TREE_CONTENT
# ===> </pre>
# ===> 
# ===> <hr>"
# ===> fi
# ===> 
# ===> if [ "$UPDATED_CONTENT" != "$FILE_CONTENT" ]; then
# ===>     echo
# ===>     echo "FILE_CONTENT is not equal to UPDATED_CONTENT"
# ===>     # Encode the updated content
# ===>     UPDATED_CONTENT=$(echo -n "$UPDATED_CONTENT" | base64)
# ===> 
# ===>     # Print debug information
# ===>     echo "TOKEN: $TOKEN"
# ===>     echo "NEW_VERSION: $NEW_VERSION"
# ===>     echo "COMMIT_SHA: $COMMIT_SHA"
# ===>     echo "FILE_SHA: $FILE_SHA"
# ===> 
# ===>     # Prepare the JSON data
# ===>     JSON_DATA=$(jq -n --arg message "$COMMIT_MESSAGE" --arg content "$UPDATED_CONTENT" --arg branch "$BRANCH" --arg sha "$FILE_SHA" \
# ===> 	       '{message: $message, content: $content, branch: $branch, sha: $sha}')
# ===> 
# ===>     # Update the file on GitHub
# ===>     RESPONSE=$(curl -s -X PUT \
# ===> 		    -H "Authorization: Bearer $TOKEN" \
# ===> 		    -H "Accept: application/vnd.github+json" \
# ===> 		    -H "X-GitHub-Api-Version: 2022-11-28" \
# ===> 		    -d "$JSON_DATA" \
# ===> 		    "https://api.github.com/repos/$REPOSITORY/contents/$FILE_PATH")
# ===> 
# ===>     echo "$RESPONSE"
# ===> fi
echo "================================================================="


