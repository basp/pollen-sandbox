#lang pollen

◊section{
    ◊h2{Matrix multiplication}

    If ◊${A} is an ◊${n \times m} matrix and ◊${B} is an ◊${m \times p} matrix, their matrix product ◊${AB} is an ◊${n \times p} matrix in which the ◊${m} entries across a row of ◊${A} are multiplied with the ◊${m} entries down a column of ◊${B} and summed to produce an entry of ◊${AB}.

    ◊$${
        A = \begin{pmatrix}
            a_{11} & a_{12} & \cdots & a_{1m} \\
            a_{21} & a_{22} & \cdots & a_{2m} \\
            \vdots & \vdots & \ddots & \vdots \\
            a_{n1} & a_{n2} & \cdots & a_{nm} 
            \end{pmatrix},

        \quad
        
        B = \begin{pmatrix}
            a_{11} & a_{12} & \cdots & a_{1m} \\
            a_{21} & a_{22} & \cdots & a_{2m} \\
            \vdots & \vdots & \ddots & \vdots \\
            a_{n1} & a_{n2} & \cdots & a_{nm} 
            \end{pmatrix}
    }

    The ◊em{matrix product} ◊${C = AB} is defined to be the ◊${n \times p} matrix

    ◊$${
        C = \begin{pmatrix}
            c_{11} & c_{12} & \cdots & c_{1p} \\
            c_{21} & c_{22} & \cdots & c_{2p} \\
            \vdots & \vdots & \ddots & \vdots \\
            c_{n1} & c_{n2} & \cdots & c_{np}
            \end{pmatrix}
    }

    Such that

    ◊$${
        c_{ij} = a_{i1}b_{1j} + \cdots + a_{im}b_{mj} = \sum_{k = 1}^m a_{ik}b_{kj}
    }
}

◊section{
    ◊h2{Translation}
}

◊section{
    ◊h2{Rotation}
}

◊section{
    ◊h2{Scaling}
}