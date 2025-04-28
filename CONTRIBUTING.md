# Contributors

We appreciate all contributions to this project, whether they are bug fixes, documentation improvements, or feature additions. This repository is maintained by students at the MSU Denver Cybersecurity Center, but contributions from anyone are welcome!

![GitHub watchers](https://img.shields.io/github/watchers/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub contributors](https://img.shields.io/github/contributors/Xata/nautilus-demo-website?style=for-the-badge)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/Xata/nautilus-demo-website?style=for-the-badge)

## How to contribute
First off, thanks for taking the time to contribute!  
This project is maintained as part of the **Cybersecurity Center at MSU Denver** to provide students hands-on experience with Docker, Kubernetes, and Git workflows.

This guide outlines how you can help.

## How to Contribute

1. **Fork the repository**  
   Click the **Fork** button at the top right of the repository page to create your own copy.

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/nautilus-demo-website.git
   cd nautilus-demo-website
   ```

3. **Create a new branch**
   Follow a clear naming pattern for your branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
   Example: `feature/add-footer`, `bugfix/fix-typo`, `doc/update-instructions`

4. **Make your changes**
   Please try to keep changes minimal, scoped, and related to a single purpose. 
   
   If you're making UI or file changes:
   - Keep the **nautilus** image intact unless replacing it with a licensed, attribution-corrected alternative.
   - Ensure the static webpage remains simple and functional — this is a **deployment validation** tool, not a full website.

5. **Commit your changes**
   Write clear, descriptive commit messages.
   ```bash
   git add .
   git commit -m "Add short, meaningful description of your change"
   ```

6. **Push and create a Pull Request (PR)**
   ```bash
   git push origin feature/your-feature-name
   ```
   Open a Pull Request from your forked repo back into the `main` branch of this repository.

## Contribution Standards

- **Documentation:** If your changes require updates to the instructions, update `README.md` too.
- **Code Quality:** Keep the website simple and Dockerfile minimal. Avoid unnecessary complexity.
- **Security:** Since this project runs inside Kubernetes clusters, avoid adding unsafe dependencies or configurations.
- **Attribution:** If you use any new external assets (images, fonts, etc.), ensure they are properly attributed and open-license friendly.

## Requirements for Contributions
- All commits must be signed off to certify DCO compliance.

- Code should be thoroughly tested before submission.

- Contributions should enhance or extend tools supporting the Cybersecurity Center’s operations and student analysts.

## Need Help?

If you're stuck or have questions, post a GitHub Issue describing the problem.
We encourage all contributors — even first-timers — to participate. Your work makes a real impact!

## Code of Conduct

All participants are expected to uphold professional and respectful behavior consistent with the [MSU Denver Student Code of Conduct](https://www.msudenver.edu/policy/student-code-of-conduct/).

Additionally:

    - Write clean, modular, and well-documented code.
    
    - Follow the established code style and conventions.
    
    - Communicate respectfully and constructively with team members, reviewers, and the broader community.
    
    - Report any behavior that violates MSU Denver's Code of Conduct to project leadership or Cybersecurity Center staff.
    

Failure to follow the Code of Conduct may result in rejection of contributions or removal from the project.
