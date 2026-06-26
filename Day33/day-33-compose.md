# Day 33 – Docker Compose

## Objective
Learn how to manage multi-container Docker applications using Docker Compose.

## Tasks Completed

- Verified Docker Compose installation.
- Created a single-container Nginx application using Compose.
- Deployed WordPress and MySQL using Compose.
- Used named volumes for MySQL data persistence.
- Connected WordPress to MySQL using the service name (`db`).
- Practiced Compose commands:
  - `docker compose up`

  ![shell_script](../images/day33_02.png)

  ![shell_script](../images/day33_01.png)

  ![shell_script](../images/day33_03.png)

  ![shell_script](../images/day33_04.png)


  - `docker compose up -d`

    ![shell_script](../images/day33_05.png)

  - `docker compose ps`

    ![shell_script](../images/day33_05.png)

  - `docker compose logs`
  - `docker compose logs <service>`
  
    ![shell_script](../images/day33_06.png)

    ![shell_script](../images/day33_07.png)

  - `docker compose stop`
  - `docker compose start`
  - `docker compose down`
  - `docker compose down -v`
  - `docker compose build`
  - `docker compose up --build`

    ![shell_script](../images/day33_08.png)

- Configured environment variables using both inline values and a `.env` file.
- Verified variable substitution using `docker compose config`.

## Key Learnings

- Docker Compose manages multiple containers from a single YAML file.
- Services communicate using service names as DNS hostnames.
- Named volumes preserve database data across container recreation.
- Compose automatically creates and manages networks.
- Environment variables improve portability and security by separating configuration from code.

## Outcome

Successfully deployed and managed multi-container applications using Docker Compose with persistent storage and environment-based configuration.