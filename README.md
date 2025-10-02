# Principles of Programming Languages — Assignment 4

Fourth assignment for **Principles of Programming Languages**.  
This project combines **functional programming in Racket** (Continuation-Passing Style & Lazy lists) with **logic programming in Prolog** (unification, graph queries, proof trees).  
Deliverables: `ex4.pdf` (theory), `ex4.rkt` (Racket code), `ex4.pl` (Prolog code).

---

## Overview

### Q1 — Continuation-Passing Style (CPS)
- Implemented `pipe$`, a CPS version of the classic `pipe` procedure, to compose unary CPS functions.  
- Proved formally that `pipe$` is **CPS-equivalent** to `pipe` (proof in `ex4.pdf`).  

### Q2 — Lazy Lists
- **`reduce1-lzl`** — reduce an entire lazy list with `(op, init)`.  
- **`reduce2-lzl`** — reduce only the first *n* elements of a lazy list.  
- **`reduce3-lzl`** — produce a lazy list of prefix-reductions (running sums).  
- **`integers-steps-from`** — generate a lazy list of integers with a configurable step (positive/negative).  
- **`generate-pi-approximations`** — lazy sequence converging to π, each element refining the approximation.  
- Explained use cases for each reduction variant and analyzed trade-offs vs. `pi-sum`.  

### Q3 — Logic Programming
#### 3.1 — Unification
- Applied the **unification algorithm** to several terms, step by step, including cases of success and failure.

#### 3.2 — Prolog Graph Predicates
- `path/3` — finds all paths between two nodes.  
- `cycle/2` — detects cycles in a graph.  
- `reverse/2` — reverses directed edges in a graph.  
- `degree/3` — computes node degree using **Church numerals**.  

#### 3.3 — Proof Trees
- Built the proof tree for `?- path(a,b,P)`.  
- Analyzed whether the tree is finite/infinite and success/failure.  

---

## Tech Stack
- **Racket** — functional programming (CPS transforms, lazy evaluation).  
- **SWI-Prolog** — logic programming (unification, graph queries, proof trees).  

---

## Skills Gained
- Continuation-Passing Style transformations and reasoning.  
- Functional programming with **lazy lists** and infinite data structures.  
- Approximating mathematical constants with infinite series.  
- Unification algorithm and logic inference.  
- Prolog graph algorithms (paths, cycles, reverse, degree).  
- Constructing and analyzing proof trees.  

---

## ▶️ How to Run

### Racket
```bash
racket ex4.rkt
