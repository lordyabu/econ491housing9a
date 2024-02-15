import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.cluster import KMeans
from scipy.spatial.distance import cdist
import networkx as nx


color_map = {
    0: '#1f77b4',  # Muted blue
    1: '#ff7f0e',  # Safety orange
    2: '#2ca02c',  # Cooked asparagus green
    3: '#d62728',  # Brick red
    4: '#9467bd',  # Muted purple
    5: '#8c564b',  # Chestnut brown
    6: '#e377c2',  # Raspberry yogurt pink
    7: '#7f7f7f',  # Middle gray
    8: '#bcbd22',  # Curry yellow-green
    9: '#17becf',  # Blue-teal
    10: '#aec7e8',  # Soft blue
    11: '#ffbb78',  # Soft orange
    12: '#98df8a',  # Pale green
    13: '#ff9896',  # Soft red
    14: '#c5b0d5',  # Pale purple
    15: '#c49c94',  # Soft brown
    16: '#f7b6d2',  # Pale pink
    17: '#c7c7c7',  # Silver gray
    18: '#dbdb8d',  # Olive green
    19: '#9edae5'   # Soft teal
}


# Generating a sample dataset
np.random.seed(0)
data = np.random.rand(10, 5)  # 10 observations, 5 variables
df_raw = pd.read_csv('./data/train.csv')

df = df_raw.select_dtypes(include = [np.number])

# Step 1: Compute the correlation matrix for the numeric-only DataFrame
corr_matrix_numeric = df.corr() ** 2

# Step 2: Perform clustering on the variables based on their correlation profiles
kmeans_numeric_variables = KMeans(n_clusters=5, random_state=0).fit(corr_matrix_numeric)

# Step 3: Create a graph where nodes are variables and edges represent correlations
G_numeric = nx.Graph()

# Adding nodes with cluster information as a node attribute
for i, var in enumerate(corr_matrix_numeric.columns):
    G_numeric.add_node(var, cluster=kmeans_numeric_variables.labels_[i])

# Adding edges. Only add edges for significant correlations (e.g., abs(corr) > 0.2)
for i, var1 in enumerate(corr_matrix_numeric.columns):
    for j, var2 in enumerate(corr_matrix_numeric.columns):
        if i < j and abs(corr_matrix_numeric.iloc[i, j]) > 0.2:  # Example threshold
            G_numeric.add_edge(var1, var2, weight=corr_matrix_numeric.iloc[i, j])

# Step 4: Color nodes based on clusters
colors_numeric = [color_map[G_numeric.nodes[node]['cluster']] for node in G_numeric.nodes]

# Plotting the graph
plt.figure(figsize=(8, 6))
# Adjusting the spring_layout parameters for better visualization
pos_numeric = nx.spring_layout(G_numeric, k=0.5, seed=42)  # Increase 'k' for more spread

# Plotting the graph with adjusted visual parameters
plt.figure(figsize=(12, 10))  # Increase figure size for better visibility

# Draw nodes with adjusted node size and color
nx.draw_networkx_nodes(G_numeric, pos_numeric, node_color=colors_numeric, node_size=800)

# Draw labels with adjusted font size and weight
nx.draw_networkx_labels(G_numeric, pos_numeric, font_size=10, font_weight='bold')

# Draw edges with adjusted transparency and color
nx.draw_networkx_edges(G_numeric, pos_numeric, alpha=0.5, edge_color='gray')

plt.title('Graph of Numeric Variables with Nodes Colored by Cluster', size=15)
plt.axis('off')  # Hide the axes
plt.show()
