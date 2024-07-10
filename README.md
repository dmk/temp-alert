# TempAlert

TempAlert is a delayed alerts service designed to serve as a reminder for various tasks for a DevOps team. Its main purpose is to notify your team about temporary changes made to your infrastructure, ensuring that these changes are revisited and resolved in a timely manner.

## Features

1. **Create Alerts for a Specific Time**: Easily create alerts to notify your team about temporary changes, set for a specific time in the future.
2. **Send Alerts to Alertmanager**: At the specified time, alerts are sent to your Alertmanager, ensuring that your team is reminded to address the temporary change.

Currently, TempAlert is compatible only with Alertmanager, but future updates may include compatibility with other alerting services based on community needs.

## Example Use Case

A practical use case for TempAlert is when a DevOps engineer modifies something on a VM to mitigate a temporary issue caused by an external service. It's easy to forget such changes, especially in a busy environment. TempAlert allows you to create an alert that will notify the team at a specified time, ensuring that the temporary change is revisited and properly resolved.
