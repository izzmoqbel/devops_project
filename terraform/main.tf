provider "aws" {
  region = "us-east-1"
}

# Create ECR Repository
resource "aws_ecr_repository" "my_app" {
  name = "devops_project"
}

# Create ECS Cluster
resource "aws_ecs_cluster" "my_app_cluster" {
  name = "devops_project_cluster"
}

# Create IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_execution_role.name
}

# Create Task Definition
resource "aws_ecs_task_definition" "my_app_task" {
  family                   = "devops_project_task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"

  container_definitions = jsonencode([{
    name      = "devops_project_container"
    image     = "${aws_ecr_repository.my_app.repository_url}:latest" # Change the tag as needed
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
  }])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

# Create Security Group
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "Allow traffic to the ECS service"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from everywhere (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create ECS Service
resource "aws_ecs_service" "my_app_service" {
  name            = "devops_project_service"
  cluster         = aws_ecs_cluster.my_app_cluster.id
  task_definition = aws_ecs_task_definition.my_app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-0fb1ef121a219b4cb"] # Replace with your subnet ID
    security_groups  = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }
}
