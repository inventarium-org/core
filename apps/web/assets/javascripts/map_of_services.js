function buildGraph(data) {
  // const data = {
  //   nodes: [
  //     {
  //       id: "node1",
  //       label: "Circle1",
  //     },
  //     {
  //       id: "node2",
  //       label: "Circle2",
  //       x: 400,
  //       y: 150
  //     }
  //   ],
  //   edges: [
  //     {
  //       source: "node1",
  //       target: "node2"
  //     }
  //   ]
  // };

  const graph = new G6.Graph({
    container: "map",
    width: 900,
    height: 700,

    modes: {
      default: [
        'drag-node', 'zoom-canvas'
      ],
    },

    layout: {
      type: 'dagre',
      rankdir: 'BT',
      align: 'DL',
      nodesep: 50,
      ranksep: 80,
      preventOverlap: true,
    },

    defaultNode: {
      shape: "rect",
      size: [200, 50],
      color: "#5B8FF9",

      style: {
        fill: "#9EC9FF",
        lineWidth: 3
      },

      labelCfg: {
        style: {
          fill: "#fff",
          fontSize: 20
        }
      }
    },

    defaultEdge: {
      style: {
        stroke: "#e2e2e2",
        opacity: 0.8,

        endArrow: {
          // The custom arrow is a path points at (0, 0), and its tail points to the positive direction of x-axis
          path: 'M 0,0 L 20,10 L 20,-10 Z',
          // the offset of the arrow, nagtive value means the arrow is moved alone the positive direction of x-axis
          // d: -10
          // styles are supported after v3.4.1
          fill: '#333',
          stroke: '#666',
          opacity: 0.8,
        }
      }
    }
  });

  graph.data(data);
  graph.render();
}
