class: center, middle

# Command-Line-Fu

An introduction to the UNIX command line for munging data.

(Source on [github](https://github.com/bjelline/command-line-fu), made with [remark](https://github.com/gnab/remark))

---

## "UNIX philosophy"


* small, sharp tools
* that can be chained together 
* to solve complex problems
* goes back to the introduction of the pipe and grep in 1973

where simple means: providing well thought out functionality,
implemented to perfection (see [grep algorigthm and implementation](http://lists.freebsd.org/pipermail/freebsd-current/2010-August/019310.html))

[wikipedia](https://en.wikipedia.org/wiki/Unix_philosophy)

---

## Command Line Keys

* use the up-arrow (and down-arrow) to go back to previouse commands
* use the tabulator key for file name completion:  type just the first letter of a filename, then try tab
* use CTRL-A to move your cursor to the beginning of the line
* use CTRL-E to move your cursor to the end of the line
* use CTRL-K to delete from the cursor to the end of the line

---

## Command Line History

* !!  repeats the last command
* !$  repeat the last word of the last command

```bash
$ mkdir this_long_directory_name
$ cd !$
```

---

## What kind of file is that?

first, let's look at the size:

```bash
$ ls -l parole 
-rw-r----- 1 bjelline admin 2286089 Feb 25 12:13 parole
$ ls -lh parole 
-rw-r----- 1 bjelline admin 2.2M Feb 25 12:13 parole
```

---

## What kind of file is that?

you don't know what might be in the file?
guess the file type:

```bash
$ file parole 
parole: ASCII text
```

if it's text, we can take a peek with less.

```bash
$ less parole
```

---

## more or less

use key commands in less (in many contexts)

  * q to quit
  * SPACE to page one down
  * CTRL-B to go back one page
  * CTRL-F to go back one page
  * G to jump to the end
  * CTRL-G to find out where you a (line number + percent)
  * 50% jump to middle of file (works for any number 0-100)
  * /cookie to search for cookie
    * n to jump to the next occurance
    * b to jump back to the previous occurance


---

## How many lines are there?

```bash
$ wc -l parole
24291 parole
```

See also man wc

---

## rename and move stuff around

now we know that 'parole' is a csv file
let's rename it:

```bash
$ mv parole parole.csv
```

See also man mv

---

## grep

find certain lines, get rid of certain files

grep will look for a string in each line, and print
the line if the string is contained.  

```bash
$ grep TRAMA parole.csv
```

---

## grep 

If there is a space in your search string you must quote it:

```bash
$ grep 'JAMES, MARK' parole.csv
```

grep is case sensitive, use -i to make it case insensitive:

```bash
$ grep -i trama parole.csv
```

---

## grep inverted

the option v turns grep around: all lines are printed, except those
matching the pattern.  this way you can get rid of certain files

```bash
$ grep -v ....
```

---

## grep enhanced

to build more complex search, with search patterns, use egrep

```bash
$ egrep 'TRAMA|TENNEY' parole.csv
```

---

## sorting

unsorted stuff

```bash
$ cat names.txt
DUQUIN, JON
MCALPINE, ERIC M
MCALPINE, ERIC M
MCALPINE, ERIC M
BROWN, STEPHANIE
BROWN, WILLIAM
BOATWRIGHT, MAURICE
PAYNE, RAYMOND
DUQUIN, JON
BROWN, WILLIAM
MCKINNEY, ROSS B
MORALES, VICTOR
DUQUIN, JON
MCALPINE, ERIC M
BYNUM, STEVEN
```


---

## sorting

sorting 

```bash
$ sort names.txt
BOATWRIGHT, MAURICE
BROWN, STEPHANIE
BROWN, WILLIAM
BROWN, WILLIAM
BYNUM, STEVEN
DUQUIN, JON
DUQUIN, JON
DUQUIN, JON
MCALPINE, ERIC M
MCALPINE, ERIC M
MCALPINE, ERIC M
MCALPINE, ERIC M
MCKINNEY, ROSS B
MORALES, VICTOR
PAYNE, RAYMOND
```


---

## sort and make uniq

```bash
$ sort names.txt | uniq 
BOATWRIGHT, MAURICE
BROWN, STEPHANIE
BROWN, WILLIAM
BYNUM, STEVEN
DUQUIN, JON
MCALPINE, ERIC M
MCKINNEY, ROSS B
MORALES, VICTOR
PAYNE, RAYMOND
```


---

## sort and count

```bash
$ sort names.txt | uniq -c
      1 BOATWRIGHT, MAURICE
      1 BROWN, STEPHANIE
      2 BROWN, WILLIAM
      1 BYNUM, STEVEN
      3 DUQUIN, JON
      4 MCALPINE, ERIC M
      1 MCKINNEY, ROSS B
      1 MORALES, VICTOR
      1 PAYNE, RAYMOND
```


---

## sort and count, sort by number

```bash
$ sort names.txt | uniq -c | sort -n
      1 BOATWRIGHT, MAURICE
      1 BROWN, STEPHANIE
      1 BYNUM, STEVEN
      1 MCKINNEY, ROSS B
      1 MORALES, VICTOR
      1 PAYNE, RAYMOND
      2 BROWN, WILLIAM
      3 DUQUIN, JON
      4 MCALPINE, ERIC M
```

---


## sort and count, sort by number, reversed

```bash
$ sort names.txt | uniq -c | sort -rn
      4 MCALPINE, ERIC M
      3 DUQUIN, JON
      2 BROWN, WILLIAM
      1 PAYNE, RAYMOND
      1 MORALES, VICTOR
      1 MCKINNEY, ROSS B
      1 BYNUM, STEVEN
      1 BROWN, STEPHANIE
      1 BOATWRIGHT, MAURICE
```


---

## top 3 by number of occurences

```bash
$ sort names.txt | uniq -c | sort -rn | head -3
      4 MCALPINE, ERIC M
      3 DUQUIN, JON
      2 BROWN, WILLIAM
```


---

## redirection 

Here we use the greater than sign for output-redirection to a file.

This will overwrite the file if it already exists, so be careful when to use it!

```bash
$ grep DENIED parole.csv > parole-denied.csv
```

---

## redirection 

if you want to add to an existing file use double greater than signs:

```bash
$ grep GRANTED parole.csv  > parole-granted.csv
$ grep PAROLED parole.csv >> parole-granted.csv
```

---

## redirection 

Using redirection you can get any program to write to a file.

How does this work?  The UNIX command line tools send their output
to a "channel" called "standard output" (or STDOUT, stdout in different programming languages).
the redirection is the general way of sending this channel to a file.

See also man bash, search for REDIRECTION

---

## pipeline

How many people were denied parole?  we just
need to count the lines:

```bash
$ grep DENIED parole.csv > parole-denied.csv
$ wc -l parole-denied.csv
```

---

## pipeline

But there is no need to create the file at all: we can creat a pipeline
with the vertical bar symbol. The pipeline connects the output
channel of grep to the input channel of wc:

```bash
$ grep DENIED parole.csv | wc -l 
```

The vertical bar is often called "pipe", so you would read
this command as: grep denied parole.csv pipe wordcount minus L

Using the pipe you can create complex programs without writing any permanent code.

---

## pipeline

When building pipes and working with large data sets, always put "| less" at the end to take a peek.

```bash
$ sort names.txt | less
$ sort names.txt | uniq -c | less
$ sort names.txt | uniq -c | sort -n | less
$ sort names.txt | uniq -c | sort -rn | less
$ sort names.txt | uniq -c | sort -rn | head -30 | less
```

---

## cutting columns from files

cut, paste


---

## handling csv files

There are the commands 'cut' and 'paste' that you might want to
use to handle comma-separated-values files.  But beware: as soon as
you have commas inside one of the columns cut will not work for you!

Here [csvkit](https://github.com/onyxfish/csvkit) comes in: 
csvkit knows about strings and escaping
in csv and will cut out the correct columns:

```bash
$ csvcut -c1,2 parole.csv
```

Now we can use the power of pipelines to learn more about a csv file

```bash
$ csvcut -c1,2 parole.csv | sort .....
```

---

## handling json files

use [jq](https://stedolan.github.io/jq/) for querying json files:

```bash
$ less example.json
{
    "status": "past", 
    "rating": {
        "count": 1, 
        "average": 5
    }, 
    "utc_offset": -18000000, 
    "group": {
        "name": "SOME CLUB", 
        "join_mode": "approval", 
        "who": "Members", 
        "id": 12345
    }, 
    "description": "<p>we haven an <b>OPEN HOUSE</b>", 
    "created": 1383331008000, 
    "updated": 1383930450000, 
```

---
## handling json files

use [jq](https://stedolan.github.io/jq/) for querying json files:

```bash
$ cat example.json | jq '.'
{
    "status": "past", 
    "rating": {
        "count": 1, 
        "average": 5
    }, 
    "utc_offset": -18000000, 
    "group": {
        "name": "SOME CLUB", 
        "join_mode": "approval", 
        "who": "Members", 
        "id": 12345
    }, 
    "description": "<p>we haven an <b>OPEN HOUSE</b>", 
    "created": 1383331008000, 
    "updated": 1383930450000, 
```

---
## handling json files

use [jq](https://stedolan.github.io/jq/) for querying json files:

```bash
$ cat example.json | jq '{id: .id, rating: .rating.average}'
{
  "id": "148644612",
  "rating": 5
}
```

---
## handling json files with array

use [jq](https://stedolan.github.io/jq/) for querying json files:

```bash
$ cat array.json
[
    {
        "status": "past", 
        "rating": {
            "count": 1, 
            "average": 5
        }, 
        "yes_rsvp_count": 8, 
        "headcount": 0, 
        "id": "148644612"
    }, 
    {
        "status": "past", 
        "rating": {
            "count": 0, 
            "average": 0
        }, 
```

---
## handling json files with array

use [jq](https://stedolan.github.io/jq/) for querying json files:

```bash
$ cat array.json | jq '.[]|{id: .id, rating: .rating.average}' | less
{
  "id": "148644612",
  "rating": 5
}
{
  "id": "150931712",
  "rating": 4.75
}
```

---

class: smallcode

## compressed files: zip

see list of file with unzip -v before uncompressing

```bash
$ unzip -v groups_new.zip
Archive:  groups_new.zip
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
       0  Stored        0   0% 10-24-2014 12:50 00000000  groups_new/
  912939  Defl:N   151623  83% 10-24-2014 10:34 d331e014  groups_new/category_1.json
 1308266  Defl:N   226343  83% 10-24-2014 10:44 51ae53a1  groups_new/category_10.json
  667660  Defl:N   112417  83% 10-24-2014 10:44 c3cbb3d4  groups_new/category_11.json
  596065  Defl:N    94715  84% 10-24-2014 10:44 9feb58bf  groups_new/category_12.json
...
  336000  Defl:N    51356  85% 10-24-2014 10:44 0b4d4b64  groups_new/category_8.json
 1545754  Defl:N   247832  84% 10-24-2014 10:44 c95bd009  groups_new/category_9.json
--------          -------  ---                            -------
40093888          6725152  83%                            36 files
```

---

class: smallcode

## compressed files: zip

see content of files with unzip -c before uncompressing

```bash
$ unzip -c groups_new.zip | less
Archive:  groups_new.zip
 extracting: groups_new/             

  inflating: groups_new/category_1.json  
[
    {
        "category": {
            "shortname": "arts-culture", 
            "name": "fine arts/culture"
        }, 
        "city": "New York", 
        "rating": 4.52, 
        "description": "<p>discussing books chosen by the members of our group.</p>", 
        "join_mode": "approval", 
        "country": "US", 
        "who": "Book Lovers", 
```

---

## compressed files: zip

uncompress

```bash
$ unzip groups_new.zip 

Archive:  groups_new.zip
   creating: groups_new/
  inflating: groups_new/category_1.json  
  inflating: groups_new/category_10.json  
  inflating: groups_new/category_11.json  
  inflating: groups_new/category_12.json  
  inflating: groups_new/category_13.json  
  inflating: groups_new/category_14.json  
  inflating: groups_new/category_15.json  

 extracting: groups_new/category_7.json  
  inflating: groups_new/category_8.json  
  inflating: groups_new/category_9.json 
---

## compressed files: gz

a .gz file contains one compressed file only.

look at the contents of that file

```bash
$ zcat some_log.1.gz
```

---

## compressed files: tgz

tgz is short for .tar.gz: the tar file contains sequence
of several files (no compression), the .gz does the compression.

look at the list of files:

```bash
$ tar tvfz data.tgz
```

uncompress

```bash
$ tar xvfz data.tgz
```

---
class: center, middle

# Into the Database


---
## Loading into the Database

* (binary) Database Dump
* SQL Dump, e.g. pg_dump, pg_restore
* Load CSV from client, e.g. \COPY
* Load CSV from server, e.g. COPY
* Load CSV as foreign table

---

## some real world pipes

```bash
$  csvcut -c3 parole.csv |cut -c1-2| 

$ csvcut -c3 parole.csv |cut -c1-2| awk '{ if (int($0) > 20) print "19$0"; else print "20$0";'

$ echo "YEAR INCARCERATION" > year_of_incarceration.txt

$ csvcut -c3 parole.csv |cut -c1-2| grep -v DI|  perl -n -e 'if($_>16) { print "19$_" } else { print "20$_" }' >> year_of_incarceration.txt

$ csvcut -c5 parole.csv | cut -d\/ -f 3 | sed -e 's/DATE/YEAR/' |head -10 > birth_year.txt

$ csvcut -c11,12 parole-3.csv | perl -n -e '($in,$birth) = split /,/; if($.==1){print "AGE AT INCARCERATION\n"} else { print $in-$birth, "\n"}' > age_at_incarceration.txt
```
---

## a famous example

[source](http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/)

```bash
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
sed ${1}q
```

McIlroy’s short, impossible-to-misunderstand explanation:

If you are not a UNIX adept, you may need a little explanation, but not much, to understand this pipeline of processes. The plan is easy:

* Make one-word lines by transliterating the complement (-c) of the alphabet into newlines (note the quoted newline), and squeezing out (-s) multiple newlines.
* Transliterate upper case to lower case.
* Sort to bring identical words together.
* Replace each run of duplicate words with a single representative and include a count (-c).
* Sort in reverse (-r) numeric (-n) order.
* Pass through a stream editor; quit (q) after printing the number of lines designated by the script’s first parameter (${1}).
