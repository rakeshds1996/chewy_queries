# ChewyQueries

This gem is completely depending on Chewy gem (Elastic search) you will get more info in [Chewy-gem](https://github.com/toptal/chewy).
First develop the index by using Chewy gem, then you can use this gem for firing the queries to get result.

## Getting started

### Requirements

This gem requires Ruby 2.4+, Rails 5.0+ and Chewy 5.2.0

### Installation

Add the gem to your `Gemfile`:

```ruby
gem 'chewy_queries'
```

and run:

```
bundle install
```
or

```
gem install chewy_queries
```

## Search query requires the following


```ruby
 def search(class_name, type, condition, value, field)
   # some elastic queries
 end
 ```

Above method includes all possible elastic queries to get the search result.

## Each argument explanation

## 1)type is fields types:
```
1)text
2)number
3)date
```

## 2)Condition required for each fields:

### a)text field
```
1)equal
2)not equal
3)contains
4)does not contain
5)starts with
6)does not start with
7)ends with
8)does not end with
9)matches exactly
```
### b)number field
```
1)Is equal to
2)Is not equal to
3)Is greater than
4)Is less than
5)Is provided
6)Is not provided
7)Is between
```
### c)date field
```
1)Is before
2)Is after
3)Is on or before
4)Is on or after
5)equals
6)does not equal
7)Is provided
8)Is not provided
9)Is between
```

## 3)value should be your search value

## 4)field should be your search filed

## Example

```ruby
#for search
 ChewyQueries::GetQuery.search(ContactIndex, "number", "Is equal to", 23, "age").limit(Contact.count)
 
 #Note:limit is to get morethan 10 result

#for exact_match_search
 ChewyQueries::GetQuery.exact_match_search(ContactIndex,"email","rakesh@example.com")
  
#for multiple_field_search 
 ChewyQueries::GetQuery.multiple_field_search(ContactIndex,["first_name","last_name","full_name"],"rakesh")
 
#for partial_search
 ChewyQueries::GetQuery.partial_search(ContactIndex,"first_name","rak")
 
 
```


# chewy_queries_new
