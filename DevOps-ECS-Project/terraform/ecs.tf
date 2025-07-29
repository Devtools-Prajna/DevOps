# terraform/ecs.tf

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "devops-ecs-cluster"
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "devops-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "devops-app"
      image     = var.docker_image_url
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "devops-app-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = [var.security_group_id]
  }

  depends_on = [aws_ecs_task_definition.app_task]
}
