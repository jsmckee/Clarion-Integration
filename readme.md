# Overview
This article outlines how to call a .NET dll from a Clarion application. In my experience documentation for Clarion is sparse and often outdated, so this article aims to provide some more recent information. Please feel free to provide feedback or suggestions on how things could work better.

# Getting Started
If you’re reading this then you should have a basic understanding of what Clarion is and what .NET is. You should also have a pretty good idea of why you’re trying to make .NET and Clarion interact, as the code examples here are quite basic.

# Versions
The example code was written with Clarion version 10.0 and .NET 4.7.2 .

# Prevent Circular Dependencies
Mixing and matching managed and unmanaged dll’s can lead to a mess. Don’t reference Clarion from .NET and the same .NET library from Clarion. Use callbacks, and reference pointers to keep things clean.

# LIB Maker
The lib-maker that ships with Clarion has a few bugs in it and you will want to get the fixed version (available here) to address those issues. This program will create the .lib file that Clarion consumes in order to map the calls to your .NET dll.

# Unmanaged Exports
Standard .NET exports won’t ‘just work’ with Clarion, so your .NET application will need to have the UnmanagedExports NuGet package by Robert Giesecke installed. This is a compile time package, and does not require any additional files with your deliverable.

# Exporting .NET Methods
First write the class and method that you want to export and I’d recommend writing a wrapper to contain the exported methods to help keep things cleaner. Exported methods need to be static so separating them allows you to do good memory management and cleanup.

# Callbacks
I found using a callback procedure worked well though you can also use reference variables, and possibly return a value though I have not had much success there yet.

To use a callback, declare a delegate type in .NET, and a matching procedure in Clarion to receive the call back. This procedure will then get passed into the .NET dll as a parameter.

# .NET Project
The .NET side is pretty straight forward:

1. Create a new library project for the .NET framework
1. Set the assembly target to x86
1. Add in some logic for the action you want to perform
1. Add the UnmanagedExports NuGet package
1. Write your static export methods and any delegates you need
1. Compile the project

# Clarion Project
On the Clarion side you will need to get the modified LibMaker, and run it against your .NET dll. If all went well you’ll see your exported methods, and you can save the .lib file it generates in a location your Clarion application can access, along with the dll files your .NET project generates and requires. Then add a reference to the generated .lib file to your Clarion applications under Libraries, Objects and Resource Files.

Next, write the .NET imports into your Clarion application’s map.


# Calling .NET Methods
To call the .NET methods you simply invoke the method that you imported just like a normal Clarion procedure:


# Conclusion
While there are a few quirks and steps involved in getting Clarion to call .NET code, its well worth the effort for many scenarios where you need the utility of .NET within a Clarion application.
