import { isAxiosError } from "axios";
import api from "../lib/axios";
import { LandCategory } from "../types";

// Obtener todas las categorías de terreno
export async function getLandCategories() {
  try {
    const { data } = await api.get<LandCategory[]>("/land-categories");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener una categoría por ID
export async function getLandCategoryById(id: number) {
  try {
    const { data } = await api.get<LandCategory>(`/land-categories/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear una nueva categoría
export async function createLandCategory(LandCategory: Omit<LandCategory, "id">) {
  try {
    const { data } = await api.post<LandCategory>("/land-categories", LandCategory);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar una categoría existente
export async function updateLandCategory(LandCategory: LandCategory) {
  try {
    const { data } = await api.put<LandCategory>(`/land-categories/${LandCategory.id}`, LandCategory);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar una categoría
export async function deleteLandCategory(id: number) {
  try {
    await api.delete(`/land-categories/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
