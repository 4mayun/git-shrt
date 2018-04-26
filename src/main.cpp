#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char* args[])
{
	const std::string fileName = "test.txt"; // Nom du fichier

    std::ifstream file (fileName); // Ouverture du fichier

	if (!file) // Test de l'ouverture du fichier
	{
		std::cout << "Une erreur est survenue lors de l'ouverture du fichier " << fileName;
		return 1;
	}

	std::cout << "Nous allons vous afficher le contenu du fichier, ligne par ligne:" << std::endl << std::endl;

	std::string line = "cc";
	for (int l = 1; getline(file, line); l++) // Tant que le curseur n'atteint pas la fin du fichier
		std::cout << "Ligne " << l << ": " << line << std::endl; // Afficher la ligne

	std::cout << std::endl << "Fin de la lecture du fichier !" << std::endl;

	file.close(); // Fermeture du fichier

	std::cout << std::endl << "Appuyez sur [Enter] pour continuer...";
	std::cin.get();
	return 0;
}

// J'ai trouvé une petite aide pour la lecture/écriture dans un fichier texte
// https://cpp.developpez.com/faq/cpp/?page=Manipulation-des-fichiers
// Attention, les articles datent de 2007, donc avant la grosse mise à jour avec le standard C++11
