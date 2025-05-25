import { isAxiosError } from "axios";
import api from "../lib/axios";
import { LandType } from "../types";

// Obtener todos los tipos de terreno
export async function getLandTypes() {
  try {
    const { data } = await api.get<LandType[]>("/land-types");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener un tipo de terreno por ID
export async function getLandTypeById(id: number) {
  try {
    const { data } = await api.get<LandType>(`/land-types/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear un nuevo tipo de terreno
export async function createLandType(landType: Omit<LandType, "id">) {
  try {
    const { data } = await api.post<LandType>("/land-types", landType);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar un tipo de terreno existente
export async function updateLandType(landType: LandType) {
  try {
    const { data } = await api.put<LandType>(`/land-types/${landType.id}`, landType);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar un tipo de terreno
export async function deleteLandType(id: number) {
  try {
    await api.delete(`/land-types/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
