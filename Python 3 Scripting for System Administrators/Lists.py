Lists
A list is created in Python by using the square brackets ([, and ]) and separating the values by commas. Here’s an example list: 
>>> my_list = [1, 2, 3, 4, 5]
There’s really not a limit to how long our list can be (there is, but it’s very unlikely that we’ll hit it while scripting). 
Reading from Lists
To access an individual element of a list, you can use the index and Python uses a zero-based index system: 
>>> my_list[0]
1
>>> my_list[1]
2
If we try to access an index that is too high (or too low) then we’ll receive an error: 
>>> my_list[5]
Traceback (most recent call last):
  File "", line 1, in 
IndexError: list index out of range
To make sure that we’re not trying to get an index that is out of range, we can test the length using the len function (and then subtract 1): 
>>> len(my_list)
5
Additionally, we can access subsections of a list by “slicing” it. We provide the starting index and the ending index (the object at that index won’t be included). 
>>> my_list[0:2]
[1, 2]
>>> my_list[1:0]
[2, 3, 4, 5]
>>> my_list[:3]
[1, 2, 3]
>>> my_list[0::1]
[1, 2, 3, 4, 5]
>>> my_list[0::2]
[1, 3, 5]
Modifying a List
Unlike strings which can’t be modified (you can’t change a character in a string), you can change a value in a list using the subscript equals operation: 
>>> my_list[0] = "a"
>>> my_list
['a', 2, 3, 4, 5]
If we want to add to a list we can use the .append method. This is an example of a method that modifies the object that is calling the method: 
>>> my_list.append(6)
>>> my_list.append(7)
>>> my_list
['a', 2, 3, 4, 5, 6, 7]
Lists can be added together (concatenated): 
>>> my_list + [8, 9, 10]
['a', 2, 3, 4, 5, 6, 7, 8, 9, 10]
>>> my_list += [8, 9, 10]
>>> my_list
['a', 2, 3, 4, 5, 6, 7, 8, 9, 10]
Items in lists can be set using slices also: 
>>> my_list[1:3] = ['b', 'c']
>>> my_list
['a', 'b', 'c', 4, 5, 6, 7, 8, 9, 10]
# Replacing 2 sized slice with length 3 list inserts new element
my_list[3:5] = ['d', 'e', 'f']
print(my_list)
We can remove a section of a list by assigning an empty list to the slice: 
>>> my_list = ['a', 'b', 'c', 'd', 5, 6, 7]
>>> my_list[4:] = []
>>> my_list
['a', 'b', 'c', 'd']
Removing items from a list based on value can be done using the .remove method: 
>>> my_list.remove('b')
>>> my_list
['a', 'c', 'd']
Attempting to remove and item that isn’t in the list will result in an error: 
>>> my_list.remove('f')
Traceback (most recent call last):
  File "", line 1, in 
ValueError: list.remove(x): x not in list
Items can also be removed from the end of a list using the pop method: 
>>> my_list = ['a', 'c', 'd']
>>> my_list.pop()
'd'
>>> my_list
['a', 'c']
We can also use the pop method to remove items at a specific index: 
>>> my_list.pop(0)
'a'
>>> my_list
['c']
>>> my_list.pop(1)
Traceback (most recent call last):
  File "", line 1, in 
IndexError: pop index out of range
>>> [].pop()
Traceback (most recent call last):
  File "", line 1, in 
IndexError: pop from empty list