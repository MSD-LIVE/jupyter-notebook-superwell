# Superwell — MSD-LIVE Jupyter Notebook

Interactive Jupyter notebook for exploring the **Superwell** global groundwater cost and supply model, hosted on MSD-LIVE.

**Live notebook:** [superwell.msdlive.org](https://superwell.msdlive.org)  
**Superwell source:** [github.com/JGCRI/superwell](https://github.com/JGCRI/superwell)

## Key Publications

1. Niazi, H., Ferencz, S. B., Graham, N. T., Yoon, J., Wild, T. B., Hejazi, M., Watson, D. J., & Vernon, C. R. (2025). [Long-term hydro-economic analysis tool for evaluating global groundwater cost and supply: Superwell v1.1](https://doi.org/10.5194/gmd-18-1737-2025). _Geoscientific Model Development, 18_(5), 1737-1767. [https://doi.org/10.5194/gmd-18-1737-2025](https://doi.org/10.5194/gmd-18-1737-2025)

2. Niazi, H., Wild, T. B., Turner, S. W. D., Graham, N. T., Hejazi, M., Msangi, S., Kim, S., Lamontagne, J. R., & Zhao, M. (2024). [Global peak water limit of future groundwater withdrawals](https://doi.org/10.1038/s41893-024-01306-w). *Nature Sustainability*, 7(4), 413–422. [https://doi.org/10.1038/s41893-024-01306-w](https://doi.org/10.1038/s41893-024-01306-w)

## Repository Structure

```
├── Dockerfile                  # Container image definition
├── docker-compose.yml          # Local testing configuration
├── inputs/                     # Bundled input data (read-only at runtime)
├── notebooks/
│   ├── requirements.txt
│   └── superwell_demo.ipynb    # Main demo notebook
└── outputs/                    # Pre-computed sample outputs
```

**Note:** All input data is bundled in `inputs/` — no S3 downloads or git clones are needed. 

## Testing Locally with Docker

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Steps

1. **Open Docker Desktop** — make sure the Docker engine is running (you'll see a green indicator in the bottom-left of Docker Desktop).

2. **Open a terminal** in the repo root and build + start the container:
   ```bash
   cd jupyter-notebook-superwell
   docker compose up --build
   ```
   The first build takes a few minutes (downloads the base image and installs dependencies). Subsequent runs are fast due to caching.

3. **Open the notebook** — look for a URL in the terminal output like:
   ```
   http://127.0.0.1:8888/lab?token=abc123...
   ```
   Copy-paste that full URL (including the token) into your browser.

4. **Navigate** to `notebooks/superwell_demo.ipynb` and run all cells.

5. **Stop the container** — press `Ctrl+C` in the terminal, or run:
   ```bash
   docker compose down
   ```

### Troubleshooting
- **"Cannot connect to the Docker daemon"** — Open Docker Desktop and wait for it to fully start.
- **Port conflict on 8888** — Change the port in `docker-compose.yml`: `"9999:8888"` then access via `http://127.0.0.1:9999/...`
- **Editing notebooks** — Changes to files in `notebooks/` are live-mounted, so edits in the browser are saved to your local files. `inputs/` is read-only.

## MSD-LIVE Deployment Notes
1. An MSD-LIVE developer will have to follow [the steps here](https://github.com/MSD-LIVE/jupyter-stacks/blob/main/MASTER_README.md) to add this as a new project notebook deployment (optionally to dev) in the prod config file. 
1. Once added, there will be an s3 bucket that this notebook's input data will need to be uploaded to. The folder uploaded to the bucket must be named 'data'. 
1. Data in the s3 bucket gets populated in one of these ways:
   1. Send the data or a link to an MSD-LIVE developer who can use the aws s3 console to upload to the bucket
   1. An MSD-LIVE developer can create aws tokens for the IAM user created when adding this project notebook deployment and securely send those tokens to the data owner to use to upload to the bucket. Links to AWS’s CLI documentation that will be helpful:
      -	How to use the access key: Authenticating using IAM user credentials for the AWS CLI - AWS Command Line Interface https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html#cli-authentication-user-configure.title
      o	Enter us-west-2 for default region name
      -	How to upload files: Using high-level (s3) commands in the AWS CLI - AWS Command Line Interface https://docs.aws.amazon.com/cli/latest/userguide/cli-services-s3-commands.html#using-s3-commands-managing-objects-sync
      -	How to delete files (or use the sync command with --delete as shown in previous link): Using high-level (s3) commands in the AWS CLI - AWS Command Line Interface https://docs.aws.amazon.com/cli/latest/userguide/cli-services-s3-commands.html#using-s3-commands-delete-objects
1. Note: it may take up to 1 hour for the data to be avilalbe to the notebook. Optionally, an MSD-LIVE developer can manually trigger the project deployment's datasync task to run right away.

## Testing the notebook on dev 
1. Dev project notebooks deployments are only availble internally to the PNNL domain. If not on site at PNNL you must be on the PNNL / Legacy PNNL VPN
1. When logging in to the notebook you must use credentials of a user registered to the DEV msdlive site (msdlive.dev.org)
1. Deployment for dev are the same steps as above but changes are made to the dev config file and files uploaded to the dev bucket

