# Geração de Malha Tubular (Hélice) com Raio Variável

**Data:** 2026-04-10
**Autor:** Mylena Carvalho Silva
**Tópicos:** Geometria Analítica, Fortran 90, Frenet-Serret, Mesh Generation.

---

## 1. Fundamentação Matemática

A geometria é construída sobre uma hélice cilíndrica paramétrica $\mathbf{x}^s(s)$. Para transformar esta linha em uma superfície 3D (tubo), anexamos um círculo de raio $r(s)$ em cada ponto da curva, orientado no plano normal de **Frenet-Serret**.

### 1.1. A Hélice Central
A curva central é definida por:
$$
\mathbf{x}^s(s) = \begin{pmatrix} R \cos(\omega s) \\ R \sin(\omega s) \\ k s \end{pmatrix}
$$
Onde:
- $R$: Raio da hélice.
- $\omega$: Velocidade angular ($2\pi \cdot \text{turns} / \text{height}$).
- $k$: Fator de inclinação vertical (pitch).

### 1.2. O Triedro de Frenet
Para orientar a seção transversal do tubo, calculamos a base ortonormal local:
1. **Normal ($\vec{N}$):** Aponta para o eixo central da hélice.
   $$\vec{N} = (-\cos(\omega s), -\sin(\omega s), 0)$$
2. **Tangente ($\vec{T}$):** Derivada normalizada de $\mathbf{x}^s(s)$.
3. **Binormal ($\vec{B}$):** Define o plano do círculo.
   $$\vec{B} = \vec{T} \times \vec{N}$$

---

## 2. Construção da Superfície (Raio Variável)

A superfície $\mathbf{C}(s,u)$ é gerada adicionando um componente radial no plano $(\vec{N}, \vec{B})$:
$$
\mathbf{C}(s,u) = \mathbf{x}^s(s) + r(s) \bigl[ \vec{N} \cos(u) + \vec{B} \sin(u) \bigr]
$$

### 2.1. Variação Linear do Raio
Implementamos uma transição linear do raio da base ($r_{base}$) para o topo ($r_{tip}$):
$$
r(s) = r_{base} + (r_{tip} - r_{base}) \cdot \frac{s}{s_{max}}
$$

---

## 3. Implementação Numérica

### Discretização
- $N_s$: Pontos ao longo do comprimento (eixo $s$).
- $N_u$: Pontos ao redor da seção circular (eixo $u$).

### Conectividade da Malha (Triangulação)
Para um grid de vértices $V_{i,j}$, cada célula quadrangular é dividida em dois triângulos:
1. **Triângulo A**: $(V_{i,j}, V_{i+1,j}, V_{i,j+1})$
2. **Triângulo B**: $(V_{i+1,j}, V_{i+1,j+1}, V_{i,j+1})$
