# Terraform + Diagrams 

Terraform + Diagrams: Provisioning and visualizing a simple environment on AWS.

[Terraform]

Language: HCL

Providers: AWS

Resources: VPC, EC2, RDS

[Diagrams]

Language: Python

Frameworks: pprint, diagrams

Enjoy it!


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

In order to run this environment, you need just install: 

- Python 3.6+

- Terraform 0.13+

For more information, see https://docs.python.org/3/using/unix.html#getting-and-installing-the-latest-version-of-python and https://learn.hashicorp.com/tutorials/terraform/install-cli

Open your terminal and clone this repository:

```
git clone https://github.com/ebarros29/diagrams-terraform

cd diagrams-terraform/
```

### Installing

A step by step series of examples that tell you how to provision the environment and run the python code (generate the diagram).

Installing Python 3.6+ and pip3

```
https://docs.python.org/3/using/unix.html#getting-and-installing-the-latest-version-of-python
```

Installing Terraform

```
https://learn.hashicorp.com/tutorials/terraform/install-cli
```

Installing dependencies

```
pip install --no-cache-dir -r requirements.txt
```

## Running the environment

Type in your terminal:

```
cd aws_terraform/

terraform plan

terraform apply [yes]

```

Wait a few minutes while Terraform finish the provisioning.

When it finish, type:

```
python3 diagrams_aws.py

```

After that, your diagram has been created in a file ".png" in your current directory ;)  

<!-- ## Running the tests

Simple tests to make sure that is everthing fine.

### Break down into end to end tests

Checking if all containers are running. You should see 2 containers up, the first one refers to web-api, the second one to mysql. 

Use the below command in order to check containers status:

```
docker ps -a
```

You can check the logs of each container using the below command:

```
docker logs <container id>
```
-->

## Authors

* **Emerson Barros** - *Initial work* - [ebarros29](https://github.com/ebarros29)

<!-- See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.-->

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
