=====================================================
Hierarchical Navigation using a UISplitviewController
=====================================================

:Author:    Stefan Eletzhofer
:Date:      2011-03-18
:Revision:  0.1dev

Abstract
========

For a internal project I needed to navigate a tree-like navigation
structure on the iPad.  There's no -- to me at last -- obvious way to
do this on the iPad w/o a *UISplitiewController*.  For this project,
I need to use **multiple** Detail View Controllers -- depending on the
navigation level and the selected cell in the Root View Controller.

I'll also need different Root View Controllers, as the contents of each
level differs, i.e. I'll have different section names, different rows.

I'd also like to be able to use a UITableViewController for the **Detail
View** and allow the user to drill down further using the Detail View.
This would cause a new Root View Controller to be pushed, and eventually
the Detail View Controller to be replaced by a new one.

**note**
  It might be possible to generalize the Root View Controller, but I'd like
  to come up with a solution to the problem first ;)

To test my ideas out, I've set up this demo project.  This is also based on
the code here: http://blog.gregfiumara.com/?p=61

What didn't work so far
=======================

- I've tried to use two UINavigationControllers for the
  UISplitiewController to allow for the Detail View to cause a drill-down.
  I used notifications to sync both UINavigationControllers, which
  ultimately became very messy, and caused the UI to freeze at times.

What does it do?
================

- Setup a *UISplitViewController* in the App Delegate
- Setup a *UITableViewController* and a *UINavigationController* as
  the Split View's Root View Controller
- Setup two different 
- Create some fake data for the Table View Controller, such that:

  - we get ten items
  - the first five items *drill down* to the next navigation level

Todo
====

- Try to implement drill-downs in the Detail View Controller.

Bugs
====

- none known as of now.

Change log
==========

0.1 - ????-??-??
----------------

- started writeup, change log
- fixed popover handling


::

 vim: set ft=rst tw=75 nocin nosi ai sw=4 ts=4 expandtab spell spelllang=en:
