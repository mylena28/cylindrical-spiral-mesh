import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Read the data
with open('spire_points.dat') as f:
    n = int(f.readline())
    points = np.zeros((n, 3))
    for i in range(n):
        points[i] = [float(x) for x in f.readline().split()]

# Plot
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot(points[:,0], points[:,1], points[:,2], 'b-', linewidth=1.5)
ax.scatter(points[:,0], points[:,1], points[:,2], c='r', s=5)
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.set_title('3D Spire (Spiral Line)')
plt.show()
