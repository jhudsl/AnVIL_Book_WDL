

# Calculate idxstats on multiple files

Now that you’ve successfully written an introductory WDL, this chapter demonstrates how WDL Workflows can easily perform an analysis across multiple genomic data files.
This material is adapted from the [WDL Bootcamp workshop](https://support.terra.bio/hc/en-us/articles/18618717942427).
For more hands-on WDL-writing exercises, see [Hands-on practice for scripting and configuring Terra workflows](https://support.terra.bio/hc/en-us/articles/360056599991).

**Learning Objectives**

- Solidify your understanding of a WDL script’s structure
- Modify a template to write a more complex WDL
- Understand how to customize a workflow’s setup with WDL

## Clone data workspace

Let’s start by navigating to the [demos-combine-data-workspaces](https://anvil.terra.bio/#workspaces/anvil-outreach/demos-combine-data-workspaces) on AnVIL-powered-by-Terra.
This workspace contains a Data Table named `sample` which contains references to four .cram files, two from the [1000 Genomes Project](https://anvil.terra.bio/#workspaces/anvil-datastorage/1000G-high-coverage-2019) and two from the [Human Pangenome Reference Consortium](https://anvil.terra.bio/#workspaces/anvil-datastorage/AnVIL_HPRC).  

Clone this workspace to create a place where you can organize your analysis.  

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g1397c25e58c_0_181.png){width=100%}

Examine the `sample` table in the Data tab to ensure that you see references to four .cram files.

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_1.png){width=100%}

In the next steps, you will write a WDL to analyze these .cram files, run the Workflow, and examine the output.

## Write an idxstats WDL

To build off of your hello-input WDL, let’s practice writing a more complex WDL. In this exercise, you’ll fill in a template script to calculate Quality Control (QC) metrics for a BAM/CRAM file using the `samtools idxstats` function.  For this exercise, there are two WDL `runtime` parameters that we **must** update for the Workflow to succeed:

- `docker` – Specify a Docker image that contains necessary software
- `disks` – Increase the disk size for each provisioned resource

Start by [downloading the template script](https://drive.google.com/file/d/1OH4L5LQNquDhNvycRHzWVH6Z1HR5R7kD) shown below. Open it in a text editor and modify it to call `samtools idxstats` on a bam file.

```
version 1.0
workflow samtoolsIdxstats {
  input {
    File bamfile 
  }
  call  {
    input: 
  }
  output {
  }
}

task  {
  input {
  }
  command <<<
  >>>
  output {
  }
  runtime {
    docker: ''
  }
}
```

Importantly, you **must**:

- Specify a Docker image that contains SAMtools (e.g. `ekiernan/wdl-101:v1`)
- Increase the disk size for each provisioned resource, e.g. `local-disk 50 HDD`

Hints:

- Follow the same general method as in the “Hello World” exercise in section 3.3.
- In this case, the input will be a BAM file.
- The output will be a file called `idxststats.txt`.
- The task will be to calculate QC metrics, using this command:

```
samtools index ~{bamfile}
samtools idxstats ~{bamfile} > counts.txt
```

Then, compare your version to the completed version below:

```
version 1.0
workflow samtoolsIdxstats {
  input {
    File bamfile
  }
  call idxstats {
    input: 
      bamfile = bamfile
  }
  output {
    File results = idxstats.idxstats
  }
}

task idxstats {
  input {
    File bamfile
  }
  command <<<
    samtools index ~{bamfile}
    samtools idxstats ~{bamfile} > idxstats.txt
  >>>
  output {
    File idxstats = "idxstats.txt"
  }
  runtime {
    disks: 'local-disk 50 HDD'
    docker: 'ekiernan/wdl-101:v1'
  }
}
```

## Optional: Run idxstats WDL on multiple .bam files

You can test this workflow out by creating a new method in the Broad Methods Repository, exporting it to your clone of the demos-combine-data-workspaces workspace, and running it on samples in  the ‘sample data table.

First, go to the “Workflows” tab and access the Broad Methods Repository through the “Find a Workflow” card:

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_6.png){width=100%}

Copy and paste the idxstats WDL you wrote above and export to your workspace (see Chapter 3 if you need a refresher).  Next, select “Run workflow(s) with inputs defined by data table” and choose the .cram files that you wish to analyze:

- Step 1: Select the `sample` table in the root entity type drop-down menu
- Step 2: Click “Select Data” and tick the checkboxes for one or more rows in the data table

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_11.png){width=100%}

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_16.png){width=100%}

Finally, configure the “Inputs” tab by specifying `this.cram` as the Attribute for the variable `bamfile` for the task `samtoolsIdxstats`.  **Don’t forget to click “Save”**.

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_21.png){width=100%}


Now run the job by clicking “Run Analysis”!  You can monitor the progress from “Queued” to “Running” to “Succeeded” in the “Job History” tab

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_47.png){width=100%}

Once the job is complete, navigate to the “Data” tab and click on “Files” to find the `idxstats.txt` output and logs by traversing through

```
submissions/<submission_id>/samtoolsIdxstats/<workflow_id>/call-idxstats/
```

![](04-calculate-idxstats_files/figure-docx//1o2XnuMbqWVLf4XrsXolIQ7ulfnMlpJlrUxN0Y8aLIVQ_g288edfe8bc0_0_53.png){width=100%}

## Customize your Workflow’s Setup with WDL

In addition to defining the workflow’s tasks, WDL scripts can define how your workflow runs in AnVIL-powered-by-Terra.

### Memory retry

Some workflows require more memory than others. But, memory is not free, so you don’t want to request more memory than you need. One solution to this tension is to start with a small amount of memory and then request more if you run out of memory. Learn how to do this from your WDL script by reading [Out of Memory Retry](https://support.terra.bio/hc/en-us/articles/4403215299355), and see [Workflow setup: VM and other options](https://support.terra.bio/hc/en-us/articles/360026521831) for a general overview of how to set up your workflow’s compute resources.

### Localizing files

It can be hard to know where your data files are located within your workspace bucket – the folders aren’t intuitively named, and often your files are saved several folders deep. 

Luckily, WDL scripts can localize your files for you. For more on this, see [How to configure workflow inputs](https://support.terra.bio/hc/en-us/articles/4415971884827), [How to use DRS URIs in a workflow](https://support.terra.bio/hc/en-us/articles/6635144998939), and [Creating a list file of reads for input to a workflow](https://support.terra.bio/hc/en-us/articles/360033353952).

If your workflow generates files, you can also write their location to a data table. This is useful for both intermediate files and the workflow’s final outputs. For more on this topic, see [Writing workflow outputs to the data table](https://support.terra.bio/hc/en-us/articles/4500420806299).
