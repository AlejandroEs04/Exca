import { isAxiosError } from "axios";
import api from "../lib/axios";
import { Owner } from "../types";

// Obtener todos los owners
export async function getOwners() {
  try {
    const { data } = await api.get<Owner[]>("/owner");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
export async function getOnwers() {
  try {
    const { data } = await api.get<Owner[]>("/owner");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener un owner por ID
export async function getOwnerById(id: number) {
  try {
    const { data } = await api.get<Owner>(`/owner/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear un nuevo owner
export async function createOwner(owner: Omit<Owner, "id">) {
  try {
    const { data } = await api.post<Owner>("/owner", owner);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar un owner existente
export async function updateOwner(owner: Owner) {
  try {
    const { data } = await api.put<Owner>(`/owner/${owner.id}`, owner);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar un owner
export async function deleteOwner(id: number) {
  try {
    await api.delete(`/owner/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
