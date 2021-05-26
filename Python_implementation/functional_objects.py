"""
Author : Tihon N.

Ce fichier à pour but de donner une implémentation d'objets fonctionnel
dans un langage qui nous est plus familier qu'Oz. 
(Nous en avons déjà vu en Java mais pourquoi pas en Python)

Le code n'est pas très élégant (quoique) mais il est fait ainsi pour bien
montrer le principe.

J'ai utilisé Python 3.8.5 pour run ce code, il est possible
que des versions antérieures ne fonctionnent pas à cause du typing.
"""
from collections import namedtuple
from copy import deepcopy
from typing import Union


"""
Cette fonction crée une stack fonctionelle.
En gros ça a le même comportement que les FList (Functional List)
qu'on faisait en Java.

On verra ci-dessous que la stack se comporte bien comme un objet fonctionnel,
c'est à dire "sans mémoire", chaque push/pop... renvoie une NOUVELLE stack tout 
en laissant l'ancienne inchangée. Si on oublie à un moment de stocker le résultat
de l'exécution dans une variable, c'est comme si rien ne s'était passé. 
(contrairement aux objets où l'objet s'est "souvenu" de l'exécution)
"""
def FunctionalStack(stack : "list[int]") -> Union["FunctionalStack", bool, int]:
    # NOTE : Tous les "deepcopy" permettent de ne pas passer par références
    #        mais de passer par valeur à la place, ce n'est probablement pas la 
    #        manière la plus efficace de faire mais c'est explicite au moins.

    def pop() -> "FunctionalStack":
		# Petit exception handling psq c'est bien
        if is_empty() :
            next_stack = stack
            raise RuntimeError("Il n'y a plus d'éléments dans la stack")

        tmp_stack : int = deepcopy(stack)
        tmp_val = tmp_stack.pop()
        return (tmp_val, FunctionalStack(tmp_stack))

    def is_empty() -> bool:
        return get_size() == 0

    def get_size() -> int:
        return len(stack)

    def push(x : int) -> "FunctionalStack":
        tmp_stack = deepcopy(stack)
        tmp_stack.append(x)
        return FunctionalStack(tmp_stack)

    def show() -> str:
        return str(stack)

    # Crée un "namedtuple", ce qui s'apparente fort à un record ou une struct en C
    Stack_record = namedtuple("Stack", ["pop", "push", "is_empty", "get_size", "show"])
    return Stack_record(pop, push, is_empty, get_size, show)

print("====================== Starting execution with functional object ======================")

# On crée une stack venant de notre super fonction stack
stack0 = FunctionalStack([])

# Ces deux variables vont servir pour observer les propriétés de la fonction
stack1 = None
stack2 = None

# Test pour voir que l'exception est bien renvoyée en cas de stack vide
try :
	stack0.pop()
except RuntimeError :
	print("C'est bon l'erreur s'est exécutée")

print(f"Le contenu de la stack0 est : {stack0.show()}")

# On push quelques éléments
print(f"Pushing 1 on the stack stack1")
stack1 = stack0.push(1)
	
print(f"Le contenu de la stack0 est : {stack0.show()}")
print(f"Le contenu de la stack1 est : {stack1.show()}")

print(f"Pushing 2 on the stack stack2")
stack2 = stack1.push(2)
	
print(f"Le contenu de la stack0 est : {stack0.show()}")
print(f"Le contenu de la stack1 est : {stack1.show()}")
print(f"Le contenu de la stack2 est : {stack2.show()}")

# On pop quelques éléments
popped_val, stack_tmp = stack2.pop()
print(f"La valeur qui vient de pop de la stack2 est {popped_val}")
print(f"Le contenu de la stack_tmp est : {stack_tmp.show()}")
print(f"Le contenu de la stack2 est : {stack2.show()}")
print(f"Est ce que stack_tmp == stack2 : {stack_tmp == stack2}")
print("====================== Ending execution ======================")



# Autre exemple avec des nombres rationnels
class RationalNumber :

    def __init__(self, num : int, den : int) -> "RationalNumber":
        self._num = num
        self._den = den

    @staticmethod
    def _euclid(n1 : int, n2 : int) -> int:
        while( n2 != 0):
            tmp = n2 
            n2 = n1 % n2 
            n1 = tmp

        return n1

    @property
    def num(self) -> int:
        return self._num 

    @property
    def den(self) -> int:
        return self._den

    # Permet d'overwrite la méthode "+"
    def __add__(self, other) -> "RationalNumber":
        tmp_num = self.num*other.den + self.den*other.num
        tmp_den = self.den*other.den

        pgcd = self._euclid(tmp_num, tmp_den)
        return RationalNumber(tmp_num//pgcd, tmp_den//pgcd)

    # Permet d'override la méthode "-"
    def __sub__(self, other) -> "RationalNumber":
        tmp_num = self.num*other.den - self.den*other.num
        tmp_den = self.den*other.den
        pgcd = self._euclid(tmp_num, tmp_den)
        return RationalNumber(tmp_num//pgcd, tmp_den//pgcd) 

    def __repr__(self) -> str:
        return f"{self.num}/{self.den}" 



print("====================== Starting execution on RationalNumber ======================")
q1 = RationalNumber(1,2)
q2 = RationalNumber(5,13)

print(f"La valeur de q1 est de {str(q1)}")
print(f"La valeur de q2 est de {str(q2)}")
print(f"La valeur de q1 + q2 est de {str(q1 + q2)}")
print(f"La valeur de q1 - q2 est de {str(q1 - q2)}")
print("====================== Ending execution ======================")
