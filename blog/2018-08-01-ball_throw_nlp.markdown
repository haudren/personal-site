---
title: Robotic ball throwing - Part 1 Non-Linear Programming with Casadi
math: true
---

Last month, I gave a talk at [Decoded #2][1] titled "Robotic Major League". As you can
guess, it was about playing baseball with robots. More specifically, pitching baseballs
with the [Jaco²][2] arm.

In the first part, I presented how to optimize throwing trajectories using Non-Linear
programming. In later posts, we will show how to achieve similar results using
Reinforcement Learning.

Problem formulation
-------------------

In this work, we suppose that we are given a target in 3D space. Thus, what we are looking
for is a robot trajectory such that the ball hits the target. More precisely:

- The ball follows a ballistic trajectory (no friction) once released
- The ball is instantly released at the end of the robot motion
- The robot is velocity controlled.

We are interested in finding the maximum velocity trajectory, i.e. the one that minimizes
the flight time.

In math terms:
$$
min. || \dot{\theta} || + w_t t \\
s.t. X_k + \dot{X}_k t + \frac{1}{2} g t^2 = T\\
     \theta_{k+1} = \theta_k + dt \dot{\theta}_k
$$

Where  ...

[1]: https://www.meetup.com/Decoded/
[2]: https://www.kinovarobotics.com/en/products/robotic-arm-series/ultra-lightweight-robotic-arm
