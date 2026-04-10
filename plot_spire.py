import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import numpy as np

# Load Mesh
with open('spire_mesh.dat', 'r') as f:
    nv, nf = map(int, f.readline().split())
    vertices = np.array([f.readline().split() for _ in range(nv)], dtype=float)
    faces = np.array([f.readline().split() for _ in range(nf)], dtype=int) - 1 # 0-indexed

fig = plt.figure(figsize=(10, 10))
ax = fig.add_subplot(111, projection='3d')

# Create the triangle collection
mesh = Poly3DCollection(vertices[faces])
mesh.set_edgecolor('k')   # Black edges to see the "faceted look" (N_u=6, 8, etc)
mesh.set_linewidth(0.1)
mesh.set_facecolor('cyan')
mesh.set_alpha(0.8)

ax.add_collection3d(mesh)

# Auto-scale
ax.set_xlim(vertices[:,0].min(), vertices[:,0].max())
ax.set_ylim(vertices[:,1].min(), vertices[:,1].max())
ax.set_zlim(vertices[:,2].min(), vertices[:,2].max())
ax.set_box_aspect([1,1,2])

plt.show()
