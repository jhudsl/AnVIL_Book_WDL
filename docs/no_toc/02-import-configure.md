

# Import and Configure Workflows

This chapter describes how to import publicly available WDL workflows and their associated configuration files.
In addition to covering the growing [Dockstore](https://dockstore.org) community — which implements and helps drive forward [GA4GH](https://www.ga4gh.org) standards — we cover the [Broad Methods Repository](https://portal.firecloud.org/#methods), which provides several convenient features if this is your first time developing WDL Workflows in the Cloud (see Chapter 3 for more details).

**Learning Objectives**

- Understand how to import workflows from Dockstore and the Broad Methods Repository
- Understand the role that JSON files play in configuring imported workflows, and how to select a configuration for your workflow

## Importing workflows into AnVIL-powered-by-Terra

Chapter 1's review exercise covers how to run a workflow that was included in a cloned AnVIL-powered-by-Terra workspace. But what if you want to add a new workflow into your workspace, without writing it yourself?

There are three ways to import workflows into an AnVIL-powered-by-Terra workspace:

- Dockstore
- Broad Methods Repository
- Other online collections

### Dockstore

[Dockstore](https://dockstore.org) is an app store for bioinformatics tools, including workflows. It provides an easy interface for finding and running workflows on AnVIL-powered-by-Terra. 

Complete the following steps to practice importing a workflow from Dockstore:

Use the instructions in [Step 1 of “How to import a workflow and its parameter file from Dockstore into Terra”](https://support.terra.bio/hc/en-us/articles/360038137292#heading-1) to find the Optimus workflow (search for WARP/Optimus).

Then, navigate to the **Versions** tab and click on the version you want to export to AnVIL-powered-by-Terra:

<img src="02-import-configure_files/figure-html//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g24c8ed805a1_1_5.png" width="100%" />

Finally, follow the instructions in [Step 2](https://support.terra.bio/hc/en-us/articles/360038137292#heading-2) to export the workflow to your cloned version of the WDL-puzzles workspace.

### Broad Methods Repository

The Broad Methods Repository contains a collection of pre-written workflows that can be run on AnVIL-powered-by-Terra. Notably, the Repository provides a web-based WDL editor, making it easy to create and modify workflows in the Cloud. Follow [these instructions](https://support.terra.bio/hc/en-us/articles/360025674392-Finding-the-workflow-method-you-need-and-its-JSON-in-the-Methods-Repository) to open the Broad Methods Repository, find an interesting workflow, and export it to your workspace. 

### Other online collections

WDL is a widely-used tool, and WDL workflows are publicly available through other sources beyond Dockstore and the Broad Methods Repository. These include [WARP](https://broadinstitute.github.io/warp), [ENCODE](https://www.encodeproject.org/pipelines), the [Genome Analysis Toolkit](https://gatk.broadinstitute.org/hc/en-us), and [GitHub](https://github.com). Note that exporting workflows from these sources is a two-step process: first, copy the workflow’s script to a new method in the Broad Methods Repository (see Chapter 3) or a Dockstore repository. Then, export the workflow to an AnVIL-powered-by-Terra workspace.

## Configuring workflows with JSON files

To run a workflow in AnVIL-powered-by-Terra, you need to specify its inputs and outputs. You can do this by hand, filling in the workflow’s configuration each time you run it. But if your workflow’s inputs are reusable across workflow submissions – for example, if you always expect to run the workflow on a column named "bam" in your data table – it’s faster and less error-prone to pre-configure your workflow. 

To pre-configure a workflow, you can upload a file that specifies the default values for some set of your workflow’s inputs. JSON is the most common format for this configuration file. AnVIL-powered-by-Terra will automatically fill these values into the workflow configuration form. If necessary. you can always change these values when running the workflow. 

<img src="02-import-configure_files/figure-html//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g24c8ed805a1_1_12.png" width="100%" />

<img src="02-import-configure_files/figure-html//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g24c8ed805a1_1_18.png" width="100%" />

### Optional practice: pre-configure a workflow

To pre-configure a workflow that you have imported to your workspace, upload a JSON file.

An easy way to do this is to download a JSON file from an existing workflow, edit it, and upload the edited version to the workflow that you’re trying to configure.

To practice this, open the **easy-puzzle-solved** workflow in your clone of the WDL-puzzles workspace and download the JSON file:

<img src="02-import-configure_files/figure-html//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g24c8ed805a1_1_24.png" width="100%" />

Open the JSON file in a text editor. It should look something like this, if the last time you ran it your input was “Marie Curie”:

```
{"HelloInput.name":"Marie Curie"}
```

Edit the file to set the input name to your name, instead of Marie Curie. Save the file, go back to your workflow and upload the edited JSON file by clicking the “Drag or click to upload json” link:

<img src="02-import-configure_files/figure-html//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g24c8ed805a1_1_30.png" width="100%" />

The input for the “name” variable should now be set to your name. Be sure to **click Save** to ensure that this change persists the next time you open the workflow.

### A few notes on syntax

If you’re configuring multiple inputs, specify them like this:

```
{"taskName.variableName1":"attribute1", "taskName.variableName2":"attribute2"}
```

If your inputs will come from a data table, specify them like this:

```
{"taskName.variableName":"${this.columnName}"}
```

### Importing a pre-configured workflow

In some cases, the workflow’s authors have provided a configuration file, and you can export this file to AnVIL-powered-by-Terra along with the workflow, rather than uploading the JSON file yourself. See [How to import a workflow and its parameter file from Dockstore into Terra](https://support.terra.bio/hc/en-us/articles/360038137292) and [Create, edit, and share a new workflow](https://support.terra.bio/hc/en-us/articles/360031366091) (steps 1.6-1.7) for instructions on how to do this for a workflow in Dockstore or the Broad Methods Repository.

### More information

To learn more about how to configure a workflow’s inputs through the UI, see [How to configure workflow inputs](https://support.terra.bio/hc/en-us/articles/4415971884827). For more detail on how to use JSON files to pre-configure a workflow, read [Getting workflows up and running faster with JSONs](https://support.terra.bio/hc/en-us/articles/360027735471).

## Further Reading

If you’re interested in a deeper dive into this chapter’s topics, check out these optional articles:

- For more information on how to monitor your workflow, read [What to expect when you submit a workflow](https://support.terra.bio/hc/en-us/articles/7093972754971).
- To learn about the costs involved in running workflows, read [How much did my workflow cost?](https://support.terra.bio/hc/en-us/articles/360037862771)
- For customizing the compute resources used to run your workflow, read [Workflow setup: VM and other options](https://support.terra.bio/hc/en-us/articles/360026521831).
- For more detail on importing workflows from Dockstore, read [How to import a workflow and its parameter file from Dockstore into Terra](https://support.terra.bio/hc/en-us/articles/360038137292).
- For more detail on importing workflows from the Broad Methods Repository, read [Finding the workflow (method) you need (and its JSON) in the Methods Repository](https://support.terra.bio/hc/en-us/articles/360025674392).
- To learn how to host and share a workflow through the Broad Methods Repository, read [Create, edit, and share a new workflow](https://support.terra.bio/hc/en-us/articles/360031366091).
