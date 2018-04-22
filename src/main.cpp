#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char* args[])
{
	const std::string fileName = "test.txt";
	
    std::ifstream file;
	file.open(fileName);
	
	if (file)
		std::cout << "Le fichier " << fileName << " s'est ouvert correctement" << std::endl;
	else
	{
		std::cout << "Une erreur est survenue lors de l'ouverture du fichier " << fileName;
		return 1;
	}
	
	std::cout << "Nous allons vous afficher le contenu du fichier, ligne par ligne:" << std::endl << std::endl;
	
	std::string line = "cc";
	for (int l = 1; file >> line; l++)
		std::cout << "Ligne " << l << ": " << line << std::endl;
	
	std::cout << std::endl << "Fin de la lecture du fichier !" << std::endl;
	
	file.close(); // Fermeture du fichier
	
	std::cout << std::endl << "Appuyez sur [Enter] pour continuer...";
	std::cin.get();
	return 0;
}
