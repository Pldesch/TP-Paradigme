"""
Author : Tihon N.

Ce fichier à pour but de donner une implémentation d'objets
dans un langage qui nous est plus familier qu'Oz.

Le code n'est pas très élégant (quoique) mais il est fait ainsi pour bien
montrer le principe.

J'ai utilisé Python 3.8.5 pour run ce code, il est possible
que des versions antérieures ne fonctionnent pas à cause du typing.
"""
from collections import namedtuple
from typing import Union


"""
Cette fonction créer un "objet" comme on l'a vu dans les slides du cours
"""
def new_stack():

	stack : list[int] = []  # ceci va être notre conteneur

	def pop() -> int:

		# Petit exception handling psq c'est bien
		if is_empty() :
			raise RuntimeError("Il n'y a plus d'éléments dans la stack")

		return stack.pop()

	def push(x : int) -> None:
		stack.append(x)

	def is_empty() -> bool:
		return get_size() == 0

	def get_size() -> int:
		return len(stack)

	# Permet de voir le contenu de la stack, sans ça nous n'y avons pas accès
	def show() -> str:
		return str(stack)

	# Crée un "namedtuple", ce qui s'apparente fort à un record ou une struct en C
	Stack_record = namedtuple("Stack", ["pop", "push", "is_empty", "get_size", "show"])

	return Stack_record(pop, push, is_empty, get_size, show)



# Comparaison avec de la bonne vieille OOP

class Stack:
    """
    Classe implémentant exactement la même chose que la fonction ci-dessus
    afin de bien montrer les différences (qui ne sont pas si grandes que ça).

		En fait, cette classe représente un ADT. La classe est elle même le couple
		wrapper/unwrapper. Si l'on regarde bien, il n'y pas moyen de modifier le contenu
		de l'objet en étant en dehors de l'objet.
    """

    def __init__(self) -> "Stack":
        self._stack = []

    def pop(self) -> Union[int, RuntimeError]:

		# Petit exception handling psq c'est bien
        if self.is_empty() :
            raise RuntimeError("Il n'y a plus d'éléments dans la stack")

        return self._stack.pop()

    def push(self, x : int) -> None:
        self._stack.append(x)

    def is_empty(self) -> bool:
        return self.get_size() == 0

    def get_size(self) -> int:
        return len(self._stack)

    # On change juste le show en méthode magique psq c'est plus joli
    def __str__(self) -> str :
        return str(self._stack)


print("====================== Starting execution with object ======================")

# On crée une stack venant de notre super fonction stack
stack = new_stack()

# Test pour voir que l'exception est bien renvoyée en cas de stack vide
try :
	stack.pop()
except RuntimeError :
	print("C'est bon l'erreur s'est exécutée")

print(f"Le contenu de la stack est : {stack.show()}")

# On push quelques éléments
for i in range(5):
	print(f"Pushing {i} on the stack")
	stack.push(i)
	
print(f"Le contenu de la stack est : {stack.show()}")

# On pop quelques éléments
while not stack.is_empty() :
	print(f"La valeur qui vient de pop de la stack est {stack.pop()}")

print(f"Le contenu de la stack est : {stack.show()}")
print("====================== Ending execution ======================")

	
print("====================== Starting execution with class (ADT) ======================")

# On crée une stack venant d'une classe
stack = Stack()

# Test pour voir que l'exception est bien renvoyée en cas de stack vide
try :
	stack.pop()
except RuntimeError :
	print("C'est bon l'erreur s'est exécutée")

print(f"Le contenu de la stack est : {str(stack)}")

# On push quelques éléments
for i in range(5):
	print(f"Pushing {i} on the stack")
	stack.push(i)
	
print(f"Le contenu de la stack est : {str(stack)}")

# On pop quelques éléments
while not stack.is_empty() :
	print(f"La valeur qui vient de pop de la stack est {stack.pop()}")

print(f"Le contenu de la stack est : {str(stack)}")
print("====================== Ending execution ======================")