# Homework #2 for UIKit course

# What issues prevent us from using storyboards in real projects?
Main issue that prevents us from using storyboard is it's actual file format (XML) and problems of solving merge conflicts on multi-people projects with it.

# What does this code do?
## 1, title.translatesAutoresizingMaskIntoConstraints = false
It prevents constraint conflicts, because if this property’s value is true, the system creates a set of constraints that duplicate the behavior specified by the view’s autoresizing mask. 

## 2. view.addSubview(title)
addSubview(UIView) Adds a view to the end of the receiver’s list of subviews. After being added, this view appears on top of any other subviews.

# What is a safe area layout guide?
It is a virtual region on device screen where UI elements can be placed. Basically, it's an area where your UI won't be conflicted by system bars for example.

# What is [weak self] on line 23 and why it is important?
It is a weak reverence to self object. If self is deallocated, program won't crash, which is kinda cool. Also if it was a strong reference, it could've created a memory leak

# What does clipsToBounds mean?
Parameter that defines if object outside of UIStack bounds is visible or not. If it's true, subviews that extend the bounds are not visible outside of them.

# What is the valueChanged type? What is Void and what is Double?
valueChanged is an optional closure that takes a Double parameter and returns nothing (Void).
Double is a data-type representing floating point numbers, and Void is a keywoard that means nothing (basically, when we put is as a return parameter for a function it means it doesn't return anything)




