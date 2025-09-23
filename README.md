Homework #2 for UIKit course

# Question №1: What issues prevent us from using storyboards in real projects?
Main issue that prevents us from using storyboard is it's actual file format (XML) and problems of solving merge conflicts on multi-people projects with it.

# What does this code do?
## 1, title.translatesAutoresizingMaskIntoConstraints = false
It prevents constraint conflicts, because if this property’s value is true, the system creates a set of constraints that duplicate the behavior specified by the view’s autoresizing mask. 

## 2. view.addSubview(title)
addSubview(UIView) Adds a view to the end of the receiver’s list of subviews. After being added, this view appears on top of any other subviews.

# What is a safe area layout guide?
It is a virtual region on device screen where UI elements can be placed. Basically, it's an area where your UI won't be conflicted by system bars for example.

