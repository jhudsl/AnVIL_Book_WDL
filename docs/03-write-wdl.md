
```r
knitr::opts_chunk$set(out.width = "100%")
```

# Write WDL

Now that you've successfully run a Workflow on AnVIL-powered-by-Terra, this tutorial demonstrates how you can create and edit a WDL using the [Broad Methods Repository](https://portal.firecloud.org/?return=anvil#methods).
While this "legacy" Methods repository does not have many of the features present in the open-source [Dockstore](https://dockstore.org/) platform, it does offer a convenient web-based editor.
This material is adapted from the [WDL 101 Workshop](https://support.terra.bio/hc/en-us/articles/8693717360411); 
you can read about other ways the Broad Methods Repository can be used in [this Terra Support article](https://support.terra.bio/hc/en-us/articles/360031366091).

**Learning Objectives**

1. Access Broad Methods Repository
1. Write a basic "hello-world" WDL
1. Export WDL to AnVIL-powered-by-Terra and run it

## Access Broad Methods Repository

Let's start by navigating to the [WDL-puzzles workspace](https://app.terra.bio/#workspaces/help-gatk/WDL-puzzles) on AnVIL-powered-by-Terra.
If you completed the review exercise in Chapter 1, you already cloned this workspace. If not, clone it to create your own copy.
Please **double check your workspace name** to ensure that this is the copy that you made rather than the original as you will not be able to use the original workspace to create a new WDL or run a workflow.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g1397c25e58c_0_185.png){width=100%}

Once you've double checked that you are in a workspace that you can modify and compute, click on the Workflows tab.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_27.png){width=100%}

Click on the Find a Workflow card.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_1.png){width=100%}

Select the Broad Methods Repository option.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_6.png){width=100%}

Click Create New Method.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_11.png){width=100%}

Add a namespace to the first text box to organize your WDLs.
Your username (perhaps prepended with your lab name) is a reasonable namespace as this must be unique across all of Broad Methods Repository.
Afterwards, add a name such as `wdl101` to name your WDL.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_16.png){width=100%}

## WDL Script Structure

Workflows are typically broken down into **tasks**, which each execute one step in the workflow’s analysis.
Tasks are written in the Workflow Description Language (**WDL**, pronounced “widdle”). WDL tasks have a consistent structure, illustrated in this example:

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g28b2946aa7c_7_6.png){width=100%}

Each task has 4 sections:

1. **Input** - defines the inputs that the task expects and their types.
1. **Command** - uses bash commands to call software tools (e.g., Python) to transform the input data.
1. **Runtime** - specifies the Docker container in which the workflow will run – we’ll discuss this more in Chapter 5.
1. **Output** - defines the output variable(s) that the transformed data will be written to.

The **workflow definition** strings together the workflow’s tasks:

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g28b2946aa7c_7_13.png){width=100%}

In this example, the workflow called “MyWorkflowName” calls two tasks (“task_A” and “task_B”). The workflow starts with an **input section**, just as the tasks do. It then calls each of the tasks, using the output from prior tasks as the inputs for subsequent tasks. Finally, workflows often include an **output** section (although the example above does not).

The workflow definition and task scripts can be written in separate WDL scripts or combined into a single script (as shown in this example).

## Write a hello-input WDL

Let's now create a basic WDL!
This simple "Hello, World!" style workflow will take a string as input, call a single task, and save the output of that task to your workspace bucket.
The task that is called will run the [Bash](https://swcarpentry.github.io/shell-novice/01-intro.html) `echo` command to print the input string to `stdout`.

First note that we are using the [WDL 1.0 spec](https://github.com/openwdl/wdl/tree/main/versions).

```
version 1.0
```

Let's add a workflow `HelloInput` that calls a single task `WriteGreeting`.

```
version 1.0
workflow HelloInput {
}

task WriteGreeting{
}
```

To create the task, we will define  `input`, `command`, `output`, and `runtime` blocks.
Note that the command block is defined as a "[here doc](https://en.wikipedia.org/wiki/Here_document)" and prints the input string to `stdout`.  

```
version 1.0
workflow HelloInput {
}

task WriteGreeting {
  input {
    String name_for_greeting
  }
  command <<<
    echo 'hello ~{name_for_greeting}!'
  >>>
  output {
    File Greeting_output = stdout()
  }
  runtime {
    docker: 'ubuntu:latest'
  }
}
```

Putting it all together, we now create the workflow by defining an input string stored in a variable named `name_input`, calling the task by passing `name_input` to `name_for_greeting`, and storing what is returned by the task in a File labeled `final_output`. 

```
version 1.0
workflow HelloInput {
  input {
    String name_input
  }
  call WriteGreeting {
    input: 
      name_for_greeting = name_input
  }
  output {
    File final_output = WriteGreeting.Greeting_output
  }
}

task WriteGreeting {
  input {
    String name_for_greeting
  }
  command <<<
    echo 'hello ~{name_for_greeting}!'
  >>>
  output {
    File Greeting_output = stdout()
  }
  runtime {
    docker: 'ubuntu:latest'
  }
}
```

## Export to AnVIL-powered-by-Terra and run

Once your WDL is complete, click on Upload.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_40.png){width=100%}

Now click on Export to Workspace.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_45.png){width=100%}

Select Use Blank Configuration.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_50.png){width=100%}

Select a Destination Workspace such as your clone of WDL-puzzles.  Afterwards, click Export to Workspace.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_55.png){width=100%}

Lastly, configure your Workflow as you did in Chapter 1 (e.g. inputs defined by file paths, name in double quotes), click Save, and then click Run Analysis.

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_60.png){width=100%}

Voila!  Here's what you hopefully see after successfully running your WDL101 Training Example !

![](03-write-wdl_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g139bf26eaed_0_65.png){width=100%}
