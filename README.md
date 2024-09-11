# optimization-project - MINIMIZING THE COST OF INSTALLING AN ELECTRIC LINE

## Description
Imagine we are at the seaside, where there is a power station located on the beach. From this station, we need to install an electric line to an offshore installation located at the specified distances in the diagram 1. The challenge is to determine how to install this electric line in a way that minimizes the total cost.

[Diagram_1](https://github.com/Grati29/optimization-project/blob/main/Diagrams/Diagram1.png)

The two immediate solutions are:

1. **Diagonal Distance**: Installing the electric line diagonally from the power station to the installation offshore. However, this means the line would be built entirely underwater, which would be the most expensive option.

2. **On Land and Vertical Connection**: Installing the line exclusively on land, followed by a vertical connection to the installation. This would involve covering the longest possible distance, which is likely not the optimal solution.


However, the optimal solution, as you might guess, is to cover part of the distance on land (which has a lower cost), and then the next part diagonally through the water.

So, how much of the electric line should be installed on land, and how much underwater to minimize the total costs?

Noting with `x` the distance for which the electric line is run on land, we define the cost function as:

Cost = on-land cost + water cost
Cost = $50 × (distance on land) + $130 × (distance in water)
Cost = 50(5000 − x) + 130√(x² + 10000²)

[Diagram_2](https://github.com/Grati29/optimization-project/blob/main/Diagrams/Diagram1.png)

## Formulating the Optimization Problem

To minimize the total cost, the problem is defined as:
**minimize 50(5000 − x) + 130√(x² + 10000²) subject to 0 ≤ x ≤ 5000**
The constraints indicate that the distance `x` cannot exceed the land distance between the two points.

## Implemented Solution

### 1. Barrier Method with Gradient

- To respect the constraints, logarithmic terms are added to the cost function, creating a "barrier" that penalizes solutions approaching the constraint limits.
- The current solution is updated using the gradient descent rule.
- Two loops are used: one for the barrier method and the other for the gradient method.
- The process stops when the solution stabilizes: the barrier terms become negligible, ensuring convergence to an optimal solution that respects the constraints.

### 2. Projected Gradient Method

- The total cost for the distances on land and water is calculated.
- The gradient of the cost function is determined.
- The current solution is updated using the gradient descent rule.
- The new solution is projected into the admissible domain, ensuring it stays within the interval [0, 5000].
- The process stops when the difference between successive solution values is below a certain tolerance or the maximum number of steps is reached.


### 3. Using `fmcon`

### 4. Solving the Problem with CVX

- The `sqrt` function could not be used directly because applying a nonlinear expression is not allowed in the convex programming context utilized by CVX, so a new decision variable `y` was introduced.
- The problem was reformulated using a second-order cone constraint.

## Project Contents

- **barrier_method_gradient.m**: Contains the implementation of the Barrier Method with Gradient Descent, used to solve the optimization problem by applying logarithmic barriers and gradient updates.

- **main.m**: This is the main script that integrates the application of the two methods (`Barrier Method with Gradient` and `Projected Gradient`), as well as the use of `Fmincon` and `CVX`. It also handles the plotting of results and the comparison between the methods.

- **projected_gradient.m**: Contains the implementation of the Projected Gradient Method, which optimizes the problem by updating the solution iteratively and ensuring it remains within the feasible domain.

## Conclusions

The Projected Gradient Method reached the solution faster compared to the Barrier Method with Gradient and also achieved a better value, indicating higher performance for this optimization problem.

Using both `Fmincon` and solving with `CVX` yielded approximately the same values compared to applying the iterative algorithms.

[Graph](https://github.com/Grati29/optimization-project/blob/main/Results/Graphs.png)  



