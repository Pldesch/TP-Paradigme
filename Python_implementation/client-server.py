"""
Author : Tihon N.

Ce fichier à pour but de donner une implémentation d'un
client-server dans un langage qui nous est plus familier qu'Oz.
Cette implémentation n'est clairement pas la plus élégante ni
la plus efficace mais elle permet de bien comprendre le principe.

J'ai utilisé Python 3.8.5 pour run ce code, il est possible
que des versions antérieures ne fonctionnent pas à cause du typing.
"""

from multiprocessing import Queue, Process # Pour pouvoir générer des clients et un serveur sur différents process
from time import sleep # Pour que les messages soient observables
import random # Pour simuler le fait que les clients envoient des messages n'importe quand


class Server :

	_max_capacity : int = 3 # Capacité maximale du server

	def __init__(self, queue):
		self._messages : list[str] = []  # Conteneur de stockage des messages
		self._queue : Queue = queue  # là où arrivent les messages

	def receive(self, msg : str) -> None :

		# On clear le contenu si il dépasse un certain seuil (pourquoi pas)
		if len(self._messages) == self._max_capacity:
			print("Clearing the content of the server. The content is :")
			print(self._messages)
			self.clear()

		self._messages.append(msg)

	def clear(self) -> None :
		self._messages = []

	# Permet la représentation de l'objet (donc permet l'utilisation de str, print ...)
	def __repr__(self) -> str :
		return str(self._messages)

	# Rend l'objet callable (comme en Java)
	def __call__(self):
		# Le process run à l'infini et essaie de prendre les messages dans la queue
		while True :
			if self._queue.qsize() > 0 :
				self.receive(self._queue.get())
				

class Client:

	def __init__(self, queue : Queue, worker_name : int, send_n : int):
		self._queue : Queue = queue 
		self._name : int = worker_name
		self._send_n : int = send_n
		
	# Rend l'objet callable (comme en Java)
	def __call__(self):
		msg_count = 0
		while msg_count < self._send_n :
			msg_count += 1
			sleep(random.random()*3)
			msg = f"The client {self._name} sent a total of {msg_count} messages."
			print(f"Sending : '{msg}' to the server.")
			self._queue.put(msg)
			

if __name__ == "__main__":
	print("================ Starting execution ===================")
	queue = Queue(10)
	server = Process(target=Server(queue))
	server.start()
	print(f"Le pid du process server est : {server.pid}")

	clients : Process = []
	for i in range(3):
		clients.append(Process(target=Client(queue, i, int(random.random()*5))))
		clients[i].start()
		print(f"The client number {i} has the pid : {clients[i].pid}")

	for client in clients :
		client.join()

	# Termine le server (cette manière de faire n'est pas propre)
	server.terminate()
	print("================ Ending execution ===================")