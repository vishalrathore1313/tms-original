Task Management System
Overview

The Task Management System is a Ruby on Rails application designed to help teams efficiently manage and track tasks and projects. It allows users to create projects, add tasks, and organize them through different stages (Backlog, In Progress, Completed). The system also supports user authentication, time zone management, and role-based access control.
Features

    User Authentication: Users can sign up, log in, and manage their profiles using Devise.

    Role Management: The system supports multiple roles, including Admin, Manager, and Team Member, each with different access permissions.

    Project and Task Management: Users can create projects and tasks, assign tasks to different stages, and update their status using a drag-and-drop interface.

    Time Zone Support: The application adjusts meeting and task times based on the user's selected time zone.

    Meeting Management: Admins and Managers can schedule meetings, invite participants, and notify them via email.

    Responsive Design: The UI is styled using Bootstrap to ensure the application looks good on all devices.



Usage
User Roles

    Admin: Can manage all aspects of the system, including users, projects, tasks, and meetings.
    Manager: Can manage projects, tasks, and meetings but has limited access to user management.
    Team Member: Can view and manage their tasks and projects but cannot create or manage meetings.

Managing Projects and Tasks

    Creating Projects: Admins and Managers can create projects from the "My Projects" page.
    Task Stages: Tasks can be moved between stages using a drag-and-drop interface. The stages include Backlog, In Progress, and Completed.

Time Zone Management

Each user can select their time zone during sign-up or profile update. All times displayed for tasks and meetings are adjusted based on the user's selected time zone.
Meetings

Admins and Managers can schedule meetings, select participants, and notify them via email. Users can view details of upcoming and past meetings, adjusted to their time zone.


Contact

For more information, please contact:

Name: Vishal Rathore
Email: vishalathore131999@gmail.com